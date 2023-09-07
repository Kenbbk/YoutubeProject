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
    
    func performRequest(completion: @escaping (Result<[VideoModel], VideoError>) -> Void) {
        let urlString = "\(videoString)&maxResults=\(maxResult)&key=\(apiKey)"
        
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
            
            guard let videoModels = self.parseJSON(data) else {
                completion(.failure(.failParsing))
                return
            }
            
            completion(.success(videoModels))
            
        }
        task.resume()
    }
    
    
    
    
    
    // JSON 데이터를 videoModel 객체 배열로 디코딩 및 데이토 구조로 반환
    func parseJSON(_ videoData: Data) -> [VideoModel]? {
        let decoder = JSONDecoder()
        
        // JSON 디코딩 중 오류 발생 시 처리
        do {
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            let videoItems = decodedData.items
            
            let videoModels = videoItems.map { item in
                return VideoModel(videoItem: item)
            }
            return videoModels
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func fetchChannelInfo(channelId: String, completion: @escaping (ChannelModel?) -> Void) {
        let channelurl = "\(channelString)&id=\(channelId)&key=\(apiKey)"
        
        if let channelInfoUrl = URL(string: channelurl) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: channelInfoUrl) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    completion(nil)
                    return
                }
                
                if let safeData = data {
                    if let channelInfo = self.parseChannelJSON(safeData) {
                        self.delegate?.didUpdateChannelInfo(channelInfo: channelInfo)
                        completion(channelInfo)
                    } else {
                        completion(nil)
                    }
                }
            }
            task.resume()
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
    
    func parseChannelJSON(_ channelData: Data) -> ChannelModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ChannelData.self, from: channelData)
            if let channelItem = decodedData.items.first {
                let channelModel = ChannelModel(channelItem: channelItem)
                return channelModel
            } else {
                return nil
            }
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

protocol ImageLoad {
    func loadImage(urlString: String, imageView: UIImageView)
}

extension ImageLoad {
    func loadImage(urlString: String, imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("데이터 가져오기 오류")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
//                    imageView.layer.cornerRadius = imageView.frame.height
//                    imageView.layer.borderWidth = 1
//                    imageView.layer.borderColor = UIColor.clear.cgColor
                    imageView.clipsToBounds = true
                }
            } else {
                print("이미지 가져오기 오류")
            }
        }
        // API 요청 시작
        task.resume()
    }
    
    
    
    
    
    
//    func getImage(urlString: String, completion: @escaping (Result<UIImage, >) -> Void)) {
//        guard let url = URL(string: urlString) else {
//            completion(
//            return }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data, error == nil else {
//                print("데이터 가져오기 오류")
//                return
//            }
//
//            if let image = UIImage(data: data) {
//               return image
//            } else {
//                print("이미지 가져오기 오류")
//            }
//        }
//        // API 요청 시작
//        task.resume()
//    }
}
