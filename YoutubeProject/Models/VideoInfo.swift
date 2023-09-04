//
//  VideoInfo.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import Foundation

struct VideoInfo {
    var videoID: String
    var title: String
    var like: Bool = false
    var comment: [Comment]
}
