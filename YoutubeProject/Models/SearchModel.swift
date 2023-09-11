//
//  SearchModel.swift
//  YoutubeProject
//
//  Created by JeonSangHyeok on 2023/09/11.
//

import Foundation

struct SearchModel: Codable {
    let nextPageToken: String
    let items: [SearchItem]
    
    init(searchData: SearchData) {
        self.nextPageToken = searchData.nextPageToken
        self.items = searchData.items
    }
}
