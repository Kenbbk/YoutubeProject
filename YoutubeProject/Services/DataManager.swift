//
//  DataManager.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation
import UIKit

protocol DataManagerDeleage {
    // 영상 정보 업데이트
    func didUpdateVideos(videos: [VideoModel])
    
    // 채널 정보 업데이트
    func didUpdateChannelInfo(channelInfo: ChannelModel)
    
    // 오류 처리
    func didFailWithError(error: Error)
}

class DataManager {
    
    // 비디오 JSON url
    let videoString = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&part=statistics&chart=mostPopular"
    
    // 채널 JSON url
    let channelString = "https://youtube.googleapis.com/youtube/v3/channels?part=snippet&part=statistics"
    
    // api 키
    let apiKey: String = "AIzaSyBelo2r12wgXFdtFoDZacVypxaRXP6V96U"
    
    // api가 갖고 있는 영상의 갯수
    var maxResult: Int = 50
    
    var delegate: DataManagerDeleage?
    
    func performRequest(categoryId: String = "", completion: @escaping (Result<[VideoModel], VideoError>) -> Void) {
        var categoryIdString = ""
        
        if categoryId != "" {
            categoryIdString = "&videoCategoryId=\(categoryId)"
        }
        
        let urlString = "\(videoString)&maxResults=\(maxResult)\(categoryIdString)&key=\(apiKey)"
        
        // url 생성
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // URLSession 생성
        let session = URLSession(configuration: .default)
        // 세션에 임무 배정
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.failDataTask))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            self.parseJSON(data, compeltion: { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                    
                    return
                case .success(let videoModels):
                    completion(.success(videoModels))
                }
            })
        }
        task.resume()
    }
    
    func parseJSON(_ videoData: Data, compeltion: @escaping (Result<[VideoModel], VideoError>) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            let videoItems = decodedData.items
            
            let videoModels = videoItems.map { item in
                return VideoModel(videoItem: item)
            }
            
            compeltion(.success(videoModels))
            
        } catch {
            compeltion(.failure(.failParsing))
            return
        }
    }

    func fetchChannelInfo(channelId: String, completion: @escaping (Result<ChannelModel, VideoError>) -> Void) {
        let channelurl = "\(channelString)&id=\(channelId)&key=\(apiKey)"
        
        guard let channelInfoURL = URL(string: channelurl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: channelInfoURL) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.failDataTask))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            self.parseChannelJSON(data) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                    return
                case .success(let channelModel):
                    completion(.success(channelModel))
                }
            }
        }
        task.resume()
    }
    
    func parseChannelJSON(_ channelData: Data, completion: @escaping (Result<ChannelModel, VideoError>) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ChannelData.self, from: channelData)
            
            guard let channelItem = decodedData.items.first else {
                completion(.failure(.failParsing))
                return
            }
            
            let channelModel = ChannelModel(channelItem: channelItem)
            
            completion(.success(channelModel))
        } catch {
            completion(.failure(.failParsing))
        }
    }
    
    func getImage(urlString: String, completion: @escaping (Result<UIImage, VideoError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.failDataTask))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.failParsing))
                return
            }
        }
        // API 요청 시작
        task.resume()
    }
}
