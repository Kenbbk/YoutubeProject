//
//  SearchVideoModels.swift
//  YoutubeProject
//
//  Created by JeonSangHyeok on 2023/09/11.
//

import Foundation

struct SearchVideoModel {
    let videoId: String
    let title: String
    let channelId: String
    let channelTitle: String
    let description: String
    let publishedAt: String
    let thumbnail: String
    
    init(searchItem: SearchItem) {
        self.videoId = searchItem.id.videoId
        self.title = searchItem.snippet.title
        self.description = searchItem.snippet.description
        self.channelId = searchItem.snippet.channelId
        self.channelTitle = searchItem.snippet.channelTitle
        self.publishedAt = searchItem.snippet.publishedAt
        self.thumbnail = searchItem.snippet.thumbnails.high.url
    }
}
