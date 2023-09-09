
import UIKit

struct User {
    let id: String
    var firstName: String
    var lastName: String
    var address: String
    let password: String
    var profileImage = UIImage()
    var backgroundImage = UIImage()
    
}

struct User1: Codable {
    let id: String
    var firstName: String
    var lastName: String
    var address: String
    let password: String
    var profileImage: String
    var backgroundImage: String
}








