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
    private lazy var userRepository = UserRepository()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: makeLoginVC())
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
        let vc = MainVC()
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return vc
    }
    
    private func makeMyPageVC() -> MyPageVC {
        //        let storyBoard = UIStoryboard(name: StoryBoards.myPage, bundle: nil)
        //        let vc = storyBoard.instantiateViewController(withIdentifier: VCIdentifier.myPageVC) as! MyPageVC
        let vc = MyPageVC()
        vc.tabBarItem = UITabBarItem(title: "My Page", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        return vc
    }
    
}
