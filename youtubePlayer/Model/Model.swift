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
    
    var commentList: [Comment]?
}


// 채널 모델
struct ChannelModel {
    let channelId: String
    let title: String
    let thumbnailURL: String
    let subscriberCount: String
}

struct UserInfo {
    let userName: String
    let userImageURL: String
}

struct Comment {
    let userName: String
    let userImageURL: String
    let comment: String
}


let userInfoList = UserInfo(userName: "전상혁", userImageURL: "https://i.namu.wiki/i/QCzfxF1JCp9K2NGB1aGCk0oUB-fLKjKTIEEZaSuvQnfIms8qCDiNKJekRnqms4aWC9EAUL5jGOeRc-06A_u5gKVnbNE-9d1qGCL32QTeiUNvJZIznWxZOqry8Z9RaafGnWjJU40t99uZLihoAIflGQ.webp")
