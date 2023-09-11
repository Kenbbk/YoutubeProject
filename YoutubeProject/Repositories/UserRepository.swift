//
//  UserRepository.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import Foundation

class UserRepository {
    
    var currentUser: User
    
    var userList: [User] = []
    
    func addUser(user: User) {
        userList.append(user)
    }
    
    func editCurrentUser(user: User) {
        self.currentUser = user
    }
    
    func getCurrentUser() -> User {
        return currentUser
    }
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
}
