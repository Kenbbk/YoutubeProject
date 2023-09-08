//
//  ImageLoad.swift
//  YoutubeProject
//
//  Created by JeonSangHyeok on 2023/09/08.
//

import Foundation
import UIKit

struct ImageLoader {
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, VideoError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.failDataTask))
                print("데이터 가져오기 오류")
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(image))
        }
        // API 요청 시작
        task.resume()
    }
}
