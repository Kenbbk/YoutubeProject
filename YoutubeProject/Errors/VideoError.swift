//
//  VideoError.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import Foundation

enum VideoError: Error {
    case invalidURL
    case failDataTask
    case noData
    case failParsing
}
