//
//  VideoModel.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation

// 영상 모델
struct VideoModel {
    let id: String
    let channelId: String
    
    let publishedAt: String
    let title: String
    let description: String
    
    let viewCount: String
    let likeCount: String
}


// 채널 모델
struct ChannelModel {
    let channelId: String
    let title: String
    let thumbnailURL: String
    let subscriberCount: String
}
