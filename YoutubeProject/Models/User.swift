
import UIKit

//struct User {
//    let id: String
//    var firstName: String
//    var lastName: String
//    var address: String
//    let password: String
//    var profileImage = UIImage()
//    var backgroundImage = UIImage()
//}

struct User1: Codable {
    let email: String
    let password: String
    var firstName: String
    var lastName: String
    var channelName: String = ""
    var profileImageData: Data?
    var backgroundImageData: Data?
//    var profileImage: String
//    var backgroundImage: String
}

struct UserImage {
//    var profileImageData: Data?
//    var backgroundImageData: Data?
}

