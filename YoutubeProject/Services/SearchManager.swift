//
//  SearchManager.swift
//  YoutubeProject
//
//  Created by JeonSangHyeok on 2023/09/09.
//

import Foundation

//class SearchManager {
//    func performRequest(_ search: String, token: String = "", completion: @escaping (Result<[SearchModel], VideoError>) -> Void) {
//        let encodeSearchString = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//        var pageToken = ""
//
//        if token != "" {
//            pageToken = "&pageToken=\(token)"
//        }
//
//        let searchURL = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=\(encodeSearchString ?? "")\(pageToken)&type=video&key=AIzaSyBelo2r12wgXFdtFoDZacVypxaRXP6V96U"
//
//        guard let url = URL(string: searchURL) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                completion(.failure(.failDataTask))
//                return
//            }
//
//            guard let data else {
//                completion(.failure(.failDataTask))
//                return
//            }
//
//            self.parseSearchJSON(data) { result in
//                switch result {
//                case .failure(let error):
//                    completion(.failure(error))
//                case .success(let searchModel):
//                    completion(.success(searchModel))
//                }
//            }
//        }
//        task.resume()
//    }
//
//    func parseSearchJSON(_ searchData: Data, completion: @escaping (Result<[SearchModel], VideoError>) -> Void) {
//        let decode = JSONDecoder()
//
//        do {
//            let decodedData = try decode.decode(SearchData.self, from: searchData)
//            let searchItems = decodedData.items
//
//            let searchModels = searchItems.map { item in
//                return SearchModel(searchData: decodedData, searchItem: item)
//            }
//
//            completion(.success(searchModels))
//        } catch {
//            completion(.failure(.failParsing))
//        }
//    }
//}
