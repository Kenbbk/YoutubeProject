//
//  CurrentUser.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//
import UIKit

class CurrentUser {
    
    static let shared = CurrentUser()
    
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var address: String = ""
    var password: String = ""
    var profileImage: UIImage = UIImage()
    var backgroundImage: UIImage = UIImage()
    
    private init() {}
}


