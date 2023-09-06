//
//  VideoModel.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import Foundation

struct VideoModel {
    let id: String
    let channelId: String
    
    let publishedAt: String
    let title: String
    let description: String
    
    let viewCount: String
    let likeCount: String
    
    var commentList: [Comment]?
}
