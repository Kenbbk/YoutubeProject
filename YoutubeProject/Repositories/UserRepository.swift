//
//  UserRepository.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import Foundation

class UserRepository {
    
    var userList: [User] = []
    
    func addUser(user: User) {
        userList.append(user)
    }
}
