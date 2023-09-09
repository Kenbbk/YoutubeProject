//
//  RegisterVC.swift
//  YoutubeProject
//
//  Created by 정일한 on 2023/09/06.
//

//  navigationController?.popViewController(animated: true)  이거를 버튼 함수에 넣으면 되돌아가진다

import UIKit

class RegisterVC: UIViewController {
    
    // MARK: - 라스트네임 입력하는 텍스트 뷰
    //첫번쨰로 뷰를 올리고
    private lazy var lastNameTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(lastNameTextField)
        view.addSubview(lastNameInfoLabel)
        return view
        
    }()
    
    // "라스트네임" 안내문구
    //두번째로 레이블을 올리고
    private let lastNameInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "last Name"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
        
    }()
    
    // 라스트네임 입력 필드
    //세번째로 텍스트 필드를 올린다
    private lazy var lastNameTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 퍼스트네임 입력하는 텍스트 뷰
    private lazy var firstNameTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(firstNameTextField)
        view.addSubview(firstNameInfoLabel)
        return view
    }()
    
    // 퍼스트네임텍스트필드의 안내문구
    private let firstNameInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "first Name"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 퍼스트네임 입력 필드
    private lazy var firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        view.addSubview(newemailInfoLabel)
        return view
    }()
    
    // "이메일" 안내문구
    private let newemailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(newpasswordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    
    // 패스워드텍스트필드의 안내문구
    private let newpasswordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
       button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 가입하기버튼
    private lazy var joinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        view.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = true
        
        //버튼에 에드타겟을 넣으면
        //밑에 1번2번3번순으로 만든다.  3번: self,#selector,touchUpInside
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [lastNameTextFieldView, firstNameTextFieldView, emailTextFieldView, passwordTextFieldView, joinButton])
        stview.spacing = 18
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    
    
    
    
    //3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    //오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var lastNameInforLabelCenterYconstraint = lastNameInfoLabel.centerYAnchor.constraint(equalTo: lastNameTextFieldView.centerYAnchor)
    
    lazy var firstNameInforLabelCenterYconstraint = firstNameInfoLabel.centerYAnchor.constraint(equalTo: firstNameTextFieldView.centerYAnchor)
    
    lazy var emailInforLabelCenterYconstraint = newemailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    
    lazy var passwordInforLabelCenterYconstraint = newpasswordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
     
        makeUI()

    }
    
    func makeUI() {
        
        view.backgroundColor = UIColor.black
        view.addSubview(stackView)
        
        lastNameInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        newemailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        newpasswordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastNameInfoLabel.leadingAnchor.constraint(equalTo: lastNameTextFieldView.leadingAnchor, constant: 8),
            lastNameInfoLabel.trailingAnchor.constraint(equalTo: lastNameTextFieldView.trailingAnchor, constant: 8),
            //lastNameInfoLabel.centerYAnchor.constraint(equalTo: lastNameTextFieldView.centerYAnchor),
            lastNameInforLabelCenterYconstraint,
            
            lastNameTextField.leadingAnchor.constraint(equalTo: lastNameTextFieldView.leadingAnchor, constant: 8),
            lastNameTextField.trailingAnchor.constraint(equalTo: lastNameTextFieldView.trailingAnchor, constant: 8),
            lastNameTextField.topAnchor.constraint(equalTo: lastNameTextFieldView.topAnchor, constant: 15),
            lastNameTextField.bottomAnchor.constraint(equalTo: lastNameTextFieldView.bottomAnchor, constant: 2),
        
            firstNameInfoLabel.leadingAnchor.constraint(equalTo: firstNameTextFieldView.leadingAnchor, constant: 8),
            firstNameInfoLabel.trailingAnchor.constraint(equalTo: firstNameTextFieldView.trailingAnchor, constant: 8),
            //firstNameInfoLabel.centerYAnchor.constraint(equalTo: firstNameTextFieldView.centerYAnchor),
            firstNameInforLabelCenterYconstraint,
            
            firstNameTextField.leadingAnchor.constraint(equalTo: firstNameTextFieldView.leadingAnchor, constant: 8),
            firstNameTextField.trailingAnchor.constraint(equalTo: firstNameTextFieldView.trailingAnchor, constant: 8),
            firstNameTextField.topAnchor.constraint(equalTo: firstNameTextFieldView.topAnchor, constant: 15),
            firstNameTextField.bottomAnchor.constraint(equalTo: firstNameTextFieldView.bottomAnchor, constant: 2),
            
            newemailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            newemailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            //newemailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
            emailInforLabelCenterYconstraint,
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
            
            newpasswordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            newpasswordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            //newpasswordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            passwordInforLabelCenterYconstraint,
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
            
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*5 + 36)
        
        
           
        
        
        ])
            
 
    }
    
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
        
    }
    
    
    
    
    
    //뒤로가기버튼이라고 생각
    //1번 objc 펑션을 만들고, 2번 버튼에 에드타겟을 해준다 3번은 위에 적혀있음
    @objc func registerButtonTapped() {
        
        // 입력 필드에서 값 얻기
        guard
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            // 필요한 경우 사용자에게 모든 필드를 채워야 함을 알리는 알림 표시
            return
        }
        
        // User 인스턴스 생성
        let user = User(id: UUID().uuidString, // 임의의 UUID 사용. 필요에 따라 변경 가능.
                        firstName: firstName,
                        lastName: lastName,
                        address: email, // 이 부분은 필요한 정보가 없기 때문에 일단 빈 문자열로 설정.
                        password: password)
        
        // UserDefaultsManager를 사용하여 사용자 저장
        UserDefaultsManager.shared.saveUser(user: user)
        
        // UserDefaults에서 사용자를 다시 가져와서 확인
        if let fetchedUser = UserDefaultsManager.shared.fetchUser() {
            print("Saved User:")
            print("ID: \(fetchedUser.id)")
            print("First Name: \(fetchedUser.firstName)")
            print("Last Name: \(fetchedUser.lastName)")
            print("Email: \(fetchedUser.address)") // 이 부분에 주의. 주소 필드에는 현재 값이 설정되지 않았습니다.
            print("Password: \(fetchedUser.password)") // 실제 앱에서는 암호를 출력하면 안 됩니다.
        } else {
            print("Failed to fetch the saved user from UserDefaults.")
        }
        
        navigationController?.popViewController(animated: true)
    }
}

    



extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == lastNameTextField {
            lastNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            lastNameInfoLabel.font = UIFont.systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            lastNameInforLabelCenterYconstraint.constant = -13
            
        }
        
        if textField == firstNameTextField {
            firstNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            firstNameInfoLabel.font = UIFont.systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            firstNameInforLabelCenterYconstraint.constant = -13
        }
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            newemailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            emailInforLabelCenterYconstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            newpasswordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            passwordInforLabelCenterYconstraint.constant = -13
            
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == lastNameTextField {
            lastNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            //빈칸이면 원래대로 돌아가기
            if lastNameTextField.text == "" {
                lastNameInfoLabel.font = UIFont.systemFont(ofSize: 18)
                lastNameInforLabelCenterYconstraint.constant = 0
                
            }
            
        }
        
        if textField == firstNameTextField {
            firstNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            //빈칸이면 원래대로 돌아가기
            if firstNameTextField.text == "" {
                firstNameInfoLabel.font = UIFont.systemFont(ofSize: 18)
                firstNameInforLabelCenterYconstraint.constant = 0
                
            }
            
        }
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            //빈칸이면 원래대로 돌아가기
            if emailTextField.text == "" {
                newemailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInforLabelCenterYconstraint.constant = 0
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            //빈칸이면 원래대로 돌아가기
            if passwordTextField.text == "" {
                newpasswordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInforLabelCenterYconstraint.constant = 0
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
            
        }
        
    }
    
    // MARK: - 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let lastname = lastNameTextField.text, !lastname.isEmpty,
            let firstname = firstNameTextField.text, !firstname.isEmpty,
            let emailaddress = emailTextField.text, !emailaddress.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            
        else {
            joinButton.backgroundColor = .clear
            joinButton.isEnabled = false
            return
        }
        joinButton.backgroundColor = .red
        joinButton.isEnabled = true
    }
        
        
        
        
}
    
    

