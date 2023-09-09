//
//  SearchModel.swift
//  YoutubeProject
//
//  Created by JeonSangHyeok on 2023/09/09.
//

import Foundation

class SearchModel {
    let nextPageToken: String
    let title: String
    
    init(searchData: SearchData, searchItem: SearchItem) {
        self.nextPageToken = searchData.nextPageToken
        self.title = searchItem.snippet.title
    }
}
