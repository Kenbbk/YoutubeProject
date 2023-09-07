//
//  ChannelModel.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import Foundation

struct ChannelModel {
    let channelId: String
    let title: String
    let thumbnailURL: String
    let subscriberCount: String
    
    init(channelItem: ChannelItem) {
        self.channelId = channelItem.id
        self.title = channelItem.snippet.title
        self.thumbnailURL = channelItem.snippet.thumbnails.default.url
        self.subscriberCount = channelItem.statistics.subscriberCount
        
    }
}

struct UserInfo {
    let userName: String
    let userImageURL: String
}


let userInfoList = UserInfo(userName: "전상혁", userImageURL: "https://i.namu.wiki/i/QCzfxF1JCp9K2NGB1aGCk0oUB-fLKjKTIEEZaSuvQnfIms8qCDiNKJekRnqms4aWC9EAUL5jGOeRc-06A_u5gKVnbNE-9d1qGCL32QTeiUNvJZIznWxZOqry8Z9RaafGnWjJU40t99uZLihoAIflGQ.webp")
