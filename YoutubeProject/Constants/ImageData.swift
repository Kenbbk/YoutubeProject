//
//  ImageData.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/11.
//

import UIKit

enum ImageData {
    
    static let defaultProfileImage = encodeImage(image: UIImage(named: "profile0")!)
    static let defaultBackgroundImage = encodeImage(image: UIImage(named: "background0")!)
    
    static func encodeImage(image: UIImage) -> Data {
        return image.jpegData(compressionQuality: 1)!
        
    }
}
