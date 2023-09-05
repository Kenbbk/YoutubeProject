//
//  ChannelData.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/05.
//

import Foundation

struct ChannelData: Codable {
    let items: [ChannelItem]
}

struct ChannelItem: Codable {
    let snippet: ChannelSnippet
    let statistics: ChannelStatistics
}

struct ChannelSnippet: Codable {
    let title: String
    let thumnails: ChannelThumbnails
}

struct ChannelThumbnails: Codable {
    let defaults: ChannelInfo
}

struct ChannelInfo: Codable {
    let url: String
}

struct ChannelStatistics: Codable {
    let subscriberCount: String
}
