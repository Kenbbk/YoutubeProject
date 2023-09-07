//
//  String+Ext.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/07.
//

import Foundation

extension String {
    
    func getHowLongAgo() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let publishedDate = dateFormatter.date(from: self)
        let result = Date().timeIntervalSince1970 - publishedDate!.timeIntervalSince1970
        if result < 60 {
            print(result)
        }
        
        switch  result {
        case  ..<60 :
            return "Now"
        case  60..<3600:
            return "\(Int(result / 60)) mintues ago"
        case 3600..<86400:
            return "\(Int(result / 3600)) days ago"
        case 86400..<2592000:
            return "\(Int(result / 86400)) months ago"
        default:
            return "\(Int(result / 2592000)) years ago"
        }
        
    }
    func formatViewCounts() -> String {
        if let intStringText =  Int(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 1
            
            var formattedString = ""
            
            switch intStringText {
            case 1000..<1_000_000:
                formattedString = formatter.string(from: NSNumber(value: Double(intStringText) / 1000.0)) ?? ""
                formattedString += "K views"
            case 10_000..<1_000_000_000:
                formattedString = formatter.string(from: NSNumber(value: Double(intStringText) / 1_000_000.0)) ?? ""
                formattedString += "M Views"
            default:
                formattedString = formatter.string(from: NSNumber(value: Double(intStringText) / 1_000_000_000.0)) ?? ""
                formattedString += "B views"
            
                formattedString = "\(intStringText)"
            }
            
            return formattedString
        }
        return ""
    }
}
