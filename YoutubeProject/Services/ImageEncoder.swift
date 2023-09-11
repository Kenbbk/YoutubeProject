//
//  ImageEncoder.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/11.
//

import UIKit
//
//struct ImageEncoder {
//
//    func encodeImage(image: UIImage, imageName: String) {
//        let image = UIImage(named: "image_name")
//
//        // Convert to Data
//        if let data = image?.pngData() {
//            // Create URL
//            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let url = documents.appendingPathComponent(imageName)
//
//            do {
//                // Write to Disk
//                try data.write(to: url)
//
//                // Store URL in User Defaults
//                UserDefaults.standard.set(url, forKey: "image")
//
//            } catch {
//                print("Unable to Write Data to Disk (\(error))")
//            }
//        }
//    }
//
//}
