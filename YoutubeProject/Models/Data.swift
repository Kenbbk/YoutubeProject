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
    let contentDetails: ContentDetails
    
}

struct ContentDetails: Codable {
    let duration: String
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
}

struct VideoThumbnailInfo: Codable {
    let url: String
    
}

struct VideoStatistics: Codable {
    let viewCount: String
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
}


// MARK: Channel Data
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
