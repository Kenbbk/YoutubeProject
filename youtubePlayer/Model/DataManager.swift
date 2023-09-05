//
//  DataManager.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation

protocol DataManagerDeleage {
    // 영상 정보 업데이트
    func didUpdateVideos(videos: [VideoModel])
    
    // 오류 처리
    func didFailWithError(error: Error)
}

class DataManager {
    
    // api 기본 값
    let videoString = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&part=statistics&chart=mostPopular"
    
    // api 키
    let apiKey: String = "AIzaSyBelo2r12wgXFdtFoDZacVypxaRXP6V96U"
    
    // api가 갖고 있는 영상의 갯수
    var maxResult: Int = 50
    
    var delegate: DataManagerDeleage?
    
    func perforRequest() {
        let urlString = "\(videoString)&maxResults=\(maxResult)&key=\(apiKey)"
        
        // url 생성
        if let url = URL(string: urlString) {
            
            // URLSession 생성
            let session = URLSession(configuration: .default)
            
            // 세션에 임무 배정
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let videos = self.parseJSON(safeData) {
                        self.delegate?.didUpdateVideos(videos: videos)
                    }
                }
            }
            // 임무 시작
            task.resume()
        }
    }
    
    // JSON 데이터를 videoModel 객체 배열로 디코딩 및 데이토 구조로 반환
    func parseJSON(_ videoData: Data) -> [VideoModel]? {
        let decoder = JSONDecoder()
        
        // JSON 디코딩 중 오류 발생 시 처리
        do {
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            let videoItems = decodedData.items
            
            let videos = videoItems.map { item in
                let videoId = item.id
                let snippet = item.snippet
                let statistics = item.statistics
                
                let date = snippet.publishedAt
                let title = snippet.title
                let description = snippet.description
                
                let viewCount = statistics.viewCount
                let likeCount = statistics.likeCount
                
                return VideoModel(id: videoId, publishedAt: date, title: title, description: description, viewCount: viewCount, likeCount: likeCount)
            }
            return videos
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
