//
//  DataManager.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation

protocol DataManagerDeleage {
    func didUpdateVideos(videos: [VideoModel])
    func didFailWithError(error: Error)
}

class DataManager {
    
    // api 기본 값
    let videoString = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular"
    
    // api 키
    let apiKey: String = "AIzaSyBelo2r12wgXFdtFoDZacVypxaRXP6V96U"
    
    // api가 갖고 있는 영상의 갯수
    var maxResult: Int = 50
    
    var delegate: DataManagerDeleage?
    
    func perforRequest() {
        let urlString = "\(videoString)&maxResults=\(maxResult)&key=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
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
            task.resume()
        }
    }
    
    func parseJSON(_ videoData: Data) -> [VideoModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            let videoItems = decodedData.items
            
            let videos = videoItems.map { item in
                let videoId = item.id
                let snippet = item.snippet
                let title = snippet.title
                
                return VideoModel(id: videoId, title: title)
            }
            return videos
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
