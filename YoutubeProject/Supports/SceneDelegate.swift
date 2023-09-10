//
//  SceneDelegate.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private lazy var tabBarController = makeTabBarVC()
    private lazy var userRepository = UserRepository(currentUser: User(email: "AA", password: "1234", firstName: "bb", lastName: "cc"))
    private lazy var dataManager = DataManager()
    private lazy var imageLoader = ImageLoader()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: makeLoginVC())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        let mainVC = makeMainVC()
        let myPageVC = makeMyPageVC()
        let myPageNavigation = UINavigationController(rootViewController: myPageVC)
        
        tabBarController.viewControllers = [mainVC, myPageNavigation]
        
    }
    
    //MARK: - VC Factory
    
    private func makeTabBarVC() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.tabBar.tintColor = .black
        return tabBar
    }
    
    private func makeLoginVC() -> LoginVC {
        
        let vc = LoginVC()
        
        vc.userRepository = self.userRepository
        vc.presentTabBar = {
            vc.present(self.tabBarController, animated: true)
        }
        
        return vc
    }
    
    private func makeMainVC() -> MainVC {
        let vc = MainVC(userRepository: userRepository, dataManager: dataManager, imageLoader: imageLoader)
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return vc
    }
    
    private func makeMyPageVC() -> MyPageVC {
        //        let storyBoard = UIStoryboard(name: StoryBoards.myPage, bundle: nil)
        //        let vc = storyBoard.instantiateViewController(withIdentifier: VCIdentifier.myPageVC) as! MyPageVC
        let vc = MyPageVC(userRepository: userRepository)
        vc.tabBarItem = UITabBarItem(title: "My Page", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        return vc
    }
    
   
   
}
