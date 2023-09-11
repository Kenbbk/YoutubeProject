//
//  SceneDelegate.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    private lazy var userRepository = UserRepository(currentUser: User(email: "aa", password: "1234", firstName: "cc", lastName: "dd", channelName: "ee", profileImageData: ImageData.defaultProfileImage, backgroundImageData: ImageData.defaultBackgroundImage))
    private lazy var dataManager = DataManager()
    private lazy var imageLoader = ImageLoader()
    private lazy var userDefaultManager = UserDefaultsManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: makeLoginVC())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    //MARK: - VC Factory
    
    private func makeTabBarVC() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.tabBar.tintColor = .black
        let mainVC = makeMainVC()
        let myPageVC = makeMyPageVC()
        let myPageNavigation = UINavigationController(rootViewController: myPageVC)
        tabBar.viewControllers = [mainVC, myPageNavigation]
        return tabBar
    }
    
    private func makeLoginVC() -> LoginVC {
        
        let vc = LoginVC(userDefaultManager: userDefaultManager)
        
        vc.userRepository = self.userRepository
        vc.presentTabBar = {
            let presentedController = self.makeTabBarVC()
            vc.present(presentedController, animated: false)
        }
        return vc
    }
    
    private func makeMainVC() -> MainVC {
        let vc = MainVC(userRepository: userRepository, dataManager: dataManager, imageLoader: imageLoader)
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return vc
    }
    
    private func makeMyPageVC() -> MyPageVC {
        let vc = MyPageVC(userRepository: userRepository, userDefaultManager: userDefaultManager)
        vc.tabBarItem = UITabBarItem(title: "My Page", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        return vc
    }
    
   
   
}
