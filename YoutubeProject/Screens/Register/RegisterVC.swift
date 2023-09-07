//
//  RegisterVC.swift
//  YoutubeProject
//
//  Created by 정일한 on 2023/09/06.
//

//  navigationController?.popViewController(animated: true)  이거를 버튼 함수에 넣으면 되돌아가진다

import UIKit

class RegisterVC: UIViewController {
    
    // MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
//        view.addSubview(emailTextField)
//        view.addSubview(emailInfoLabel)
        return view
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     
        makeUI()

    }
    
    func makeUI() {
       
      
        
    }
    
    
    
    
    
    
    
 
    }
    
  
    
 
 
    
    
    
    
    
    
   
