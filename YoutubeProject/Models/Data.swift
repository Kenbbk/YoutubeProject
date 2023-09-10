//
//  VideoData.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation

// MARK: - Video Data
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

// MARK: - Search Data
struct SearchData: Codable {
    let nextPageToken: String
    let items: [SearchItem]
}

struct SearchItem: Codable {
    let snippet: SearchSnippet
}

struct SearchSnippet: Codable {
    let title: String
    let description: String
    let channelId: String
    let thumbnails: SearchThumbnail
    let channelTitle: String
    let publishTime: String
}

struct SearchThumbnail: Codable {
    let `default`: SearchThumbnailInfo
    let medium: SearchThumbnailInfo
    let high: SearchThumbnailInfo
}

struct SearchThumbnailInfo: Codable {
    let url: String
}


// MARK: - Channel Data
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
