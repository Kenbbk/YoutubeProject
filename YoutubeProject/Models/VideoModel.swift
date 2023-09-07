//
//  VideoModel.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import Foundation

struct VideoModel: Equatable, Hashable {
    let id: String
    let channelId: String
    let channelTitle: String
    let publishedAt: String
    let title: String
    let description: String
    
    let viewCount: String
    let likeCount: String
    let thumbnails: String
    var commentList: [Comment] = []
    
    init(videoItem: VideoItem) {
        self.channelTitle = videoItem.snippet.channelTitle
        self.id = videoItem.id
        self.channelId = videoItem.snippet.channelId
        self.publishedAt = videoItem.snippet.publishedAt
        self.title = videoItem.snippet.title
        self.description = videoItem.snippet.description
        self.viewCount = videoItem.statistics.viewCount
        self.likeCount = videoItem.statistics.likeCount
        self.thumbnails = videoItem.snippet.thumbnails.standard.url
        self.commentList = []
        
    }
    
    static func == (lhs: VideoModel, rhs: VideoModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
