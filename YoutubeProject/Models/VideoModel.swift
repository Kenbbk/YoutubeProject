//
//  VideoModel.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import Foundation

class VideoModel: Equatable, Hashable {
    let id: String
    let channelId: String
    let channelTitle: String
    let publishedAt: String
    let title: String
    let description: String
    let duration: String
    let viewCount: String
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
        self.thumbnails = videoItem.snippet.thumbnails.high.url
        self.commentList = []
        self.duration = videoItem.contentDetails.duration
    }
    
    static func == (lhs: VideoModel, rhs: VideoModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
