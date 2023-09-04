//
//  VideoData.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import Foundation

struct VideoData: Codable {
    let items: [VideoItem]
}

struct VideoItem: Codable {
    let id: String
    let snippet: VideoSnippet
}

struct VideoSnippet: Codable {
    let title: String
    //let description: String
}
