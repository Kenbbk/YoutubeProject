
import UIKit



struct User: Codable {
    let email: String
    let password: String
    var firstName: String
    var lastName: String
    var channelName: String = ""
    var profileImageData: Data
    var backgroundImageData: Data
    
}



