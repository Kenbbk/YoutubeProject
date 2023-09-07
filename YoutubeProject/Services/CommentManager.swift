//
//  CommentManager.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/06.
//

import Foundation

class CommentManager {
    static let shared = CommentManager()
    
    private var comments: [String: [Comment]] = [:]
    
    func addComment(_ comment: Comment, videoId: String) {
        if var videoComments = comments[videoId] {
            videoComments.append(comment)
            comments[videoId] = videoComments
        } else {
            comments[videoId] = [comment]
        }
    }
    
    func getComments(videoId: String) -> [Comment] {
        return comments[videoId] ?? []
    }
}
