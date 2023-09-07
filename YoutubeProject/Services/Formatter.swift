//
//  Formatter.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/06.
//

import Foundation

class Formatter {
    
    static func formatLikeCount(_ stringText: String) -> String {
        if let intStringText =  Int(stringText) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 1
            
            var formattedString = ""
            
            switch intStringText {
            case 1000..<10_000:
                formattedString = formatter.string(from: NSNumber(value: Double(intStringText) / 1000.0)) ?? ""
                formattedString += "천"
            case 10_000..<100_000_000:
                formattedString = formatter.string(from: NSNumber(value: Double(intStringText) / 10_000.0)) ?? ""
                formattedString += "만"
            case 100_000_000..<100_000_000_000:
                formattedString = formatter.string(from: NSNumber(value: Double(intStringText) / 100_000_000.0)) ?? ""
                formattedString += "억"
            default:
                formattedString = "\(intStringText)"
            }
            
            return formattedString
        }
        return stringText
    }
    
    static func formatViewCount(_ viewCount: String) -> String {
        if let intViewCount = Int(viewCount) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            return formatter.string(from: NSNumber(value: intViewCount)) ?? ""
        }
        return viewCount
    }
    
    static func formatDate(_ dateString: String) -> (year: String, mothDay: String)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        if let date = dateFormatter.date(from: dateString) {
            let calender = Calendar.current
            let year = String(calender.component(.year, from: date))
            let month = String(format: "%02d", calender.component(.month, from: date))
            let day = String(format: "%02d", calender.component(.day, from: date))
            
            let yearString = "\(year)년"
            let monthDay = "\(month)월 \(day)일"
            
            return (yearString, monthDay)
        }
        return nil
    }
}
