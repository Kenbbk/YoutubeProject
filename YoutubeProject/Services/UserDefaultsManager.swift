
import Foundation

class UserDefaultsManager {
    
    let userDefaults = UserDefaults.standard
    
    func saveUser(user: User) { // 값 저장하기
        do {
            let encodedData = try JSONEncoder().encode(user)
            userDefaults.set(encodedData, forKey: user.email)
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    func fetchUser(email: String) -> User? { // 저장된 값 가져오기
        if let savedUser = userDefaults.object(forKey: email) as? Data {
            do {
                let decodedUser = try JSONDecoder().decode(User.self, from: savedUser)
                return decodedUser
            } catch {
                print("Failed to decode user: \(error)")
            }
        }
        return nil
    }
    
    func Login(user: User) {
        let key = "Login"
        do {
            let encodedData = try JSONEncoder().encode(user)
            userDefaults.set(encodedData, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func logout() {
        let key = "Login"
        
        userDefaults.removeObject(forKey: key)
       
    }
    
    func checkLoginAndGetUser() -> User? {
        let key = "Login"
        if let logginedUser = userDefaults.object(forKey: key) as? Data {
            do {
                let decodedUser = try JSONDecoder().decode(User.self, from: logginedUser)
                return decodedUser
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    
    
    
}
