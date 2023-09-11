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
