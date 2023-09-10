//
//  DataFormatter.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/10.
//

import Foundation

struct DataFormatter {
    
    func makeLongVideos(models: [VideoModel]) {
        var models = models
        var firstVideo: [VideoModel] = []
        var secondViedo: [VideoModel] = []
        var thirdVideos: [VideoModel] = []
        if models.count > 0 {
            firstVideo.append(models[0])
            models.remove(at: 0)
        }
        
        if models.count > 0 {
            secondViedo.append(models[0])
            models.remove(at: 0)
        }
        
        
    }
}
