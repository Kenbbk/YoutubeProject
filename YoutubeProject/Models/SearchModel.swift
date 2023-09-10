//
//  SearchModel.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/09.
//

import Foundation

struct SearchModel: Codable {
    let nextPageToken: String
    let items: [VideoItem]
}
