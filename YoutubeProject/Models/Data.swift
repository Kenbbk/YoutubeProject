//
//  VideoData.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation

// 영상
struct VideoData: Codable {
    let items: [VideoItem]
}

struct VideoItem: Codable {
    let id: String
    let snippet: VideoSnippet
    let statistics: VideoStatistics
}

struct VideoSnippet: Codable {
    let channelId: String
    let title: String
    let description: String
    let publishedAt: String
    let channelTitle: String
    let thumbnails: VideoThumbnail
}

struct VideoThumbnail: Codable {
    let `default`: VideoThumbnailInfo
    let medium: VideoThumbnailInfo
    let high: VideoThumbnailInfo
    let standard: VideoThumbnailInfo
//    let maxres: VideoThumbnailInfo
}

struct VideoThumbnailInfo: Codable {
    let url: String
    
}

struct VideoStatistics: Codable {
    let viewCount: String
//    let likeCount: String
}

// 채널
struct ChannelData: Codable {
    let items: [ChannelItem]
}

struct ChannelItem: Codable {
    let id: String
    let snippet: ChannelSnippet
    let statistics: ChannelStatistics
}

struct ChannelSnippet: Codable {
    let title: String
    let thumbnails: ChannelThumbnails
}

struct ChannelThumbnails: Codable {
    let `default`: ChannelInfo
}

struct ChannelInfo: Codable {
    let url: String
}

struct ChannelStatistics: Codable {
    let subscriberCount: String
}
