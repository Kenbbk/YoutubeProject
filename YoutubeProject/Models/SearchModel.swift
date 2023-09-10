//
//  SearchModel.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/09.
//  Created by JeonSangHyeok on 2023/09/09.
//

import Foundation

struct SearchModel: Codable {
    let nextPageToken: String
    let items: [VideoItem]
  
class SearchModel {
    let nextPageToken: String
    let title: String
    
    init(searchData: SearchData, searchItem: SearchItem) {
        self.nextPageToken = searchData.nextPageToken
        self.title = searchItem.snippet.title
    }
}
