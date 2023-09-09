
import UIKit

struct User: Codable {
    let id: String
    var firstName: String
    var lastName: String
    var address: String
    let password: String
    var profileImageData: Data?
    var backgroundImageData: Data?
    
    // Helper properties for UIImage
    var profileImage: UIImage? {
        get {
            if let data = profileImageData {
                return UIImage(data: data)
            }
            return nil
        }
        set {
            profileImageData = newValue?.pngData()
        }
    }
    
    var backgroundImage: UIImage? {
        get {
            if let data = backgroundImageData {
                return UIImage(data: data)
            }
            return nil
        }
        set {
            backgroundImageData = newValue?.pngData()
        }
    }
 
}

class UserDefaultsManager {

static let shared = UserDefaultsManager()
private init() {}

let userDefaults = UserDefaults.standard
private let userKey = "savedUser"

func saveUser(user: User) {
do {
let encodedData = try JSONEncoder().encode(user)
userDefaults.set(encodedData, forKey: userKey)
} catch {
print("Failed to save user: \(error)")
}
}

func fetchUser() -> User? {
if let savedUser = userDefaults.object(forKey: userKey) as? Data {
do {
let decodedUser = try JSONDecoder().decode(User.self, from: savedUser)
return decodedUser
} catch {
print("Failed to decode user: \(error)")
}
}
return nil
}

func deleteUser() {
userDefaults.removeObject(forKey: userKey)
}
}


    var profileImage = UIImage()
    var backgroundImage = UIImage()
}
