//
//  LoginVC.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import UIKit

class LoginVC: UIViewController {
    
    var userRepository: UserRepository?
    
     var presentTabBar: (() -> Void)?
    
    private lazy var button: UIButton = {
       let button = UIButton(frame: CGRect(x: 200, y: 200, width: 300, height: 300))
        button.backgroundColor = .brown
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
    }
    
    @objc private func buttonTapped() {
        presentTabBar?()
    }
    
    // viewController 만들어줌 let vc = MyPageVC()
    // viewcontroller present(), navigationController.push(viewCOntroller: vc) 보내버림
}
