
import UIKit

class MyPageVC: UIViewController {
    
    //MARK: - Properties
    
    private var user: User?
    
    lazy var safeArea = view.safeAreaLayoutGuide

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile5")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 65
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        return imageView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background1")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
    
        return label
    }()
    
    let userAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(profileEditButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var likeVideoButton: UIButton = {
        let button = UIButton()
        button.setTitle("좋아요 표시한 동영상", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(likeVideoButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        initiateUser()
        setUserInfoLabels()
        
    }
    
    //MARK: - Actions
    
    @objc func profileEditButtonTapped(_ button: UIButton){
        let editVC = ProfileEditVC()
        
        editVC.myPageVC = self
        // MyPageVC User Data -> ProfileEditVC text로 전달
        editVC.firstNameTextField.text = self.user?.firstName
        editVC.lastNameTextField.text = self.user?.lastName
        editVC.addressTextField.text = self.user?.address
        
        // address 앞에 @ 붙이기
        if let userAddress = self.user?.address {
            editVC.addressDataLabel.text = "@" + userAddress
        } else {
            editVC.addressDataLabel.text = nil
        }
        
        // MyPageVC 이미지뷰의 이미지 -> ProfileEditVC 이미지뷰로 전달
        editVC.profileImage = self.profileImageView.image
        editVC.backgroundImage = self.backgroundImageView.image
        
        editVC.delegate = self
        self.present(editVC, animated: true)
    }
    
    @objc func likeVideoButtonTapped(_ button: UIButton){
        let likeVideoVC = LikeVideoVC()
        likeVideoVC.myPageVC = self
//        likeVideoVC.delegate = self
        // likeVideoVC로 화면 전환
        self.navigationController?.pushViewController(likeVideoVC, animated: true)
    }
    
    @objc func logoutButtonTapped(_ button: UIButton){
     
    }
    
    
    //MARK: - Helper
    
    func setUserInfoLabels(){
        // User 데이터 가지고 오기
        if let user = user {
            userNameLabel.text = "\(user.lastName)\(user.firstName)"
            userAddressLabel.text = "@\(user.address)"
        }
        
    }
    
    func initiateUser(){
        // User 초기화
        user = User(id: "User1", firstName: "구름", lastName: "정", address: "KingGuruem", password: "1234")
    }
}

extension MyPageVC: SendDataDelegate {
    func didEditUserInfo(data: EditUserInfo) {
        // EditUserInfo 객체를 통해 수정된 데이터 전달받기
        self.user?.firstName = data.editFirstName
        self.user?.lastName = data.editLastName
        self.user?.address = data.editAddress
        self.setUserInfoLabels()
    }
}


//MARK: - UI
extension MyPageVC {
    
    func configureUI() {
        // configureUI 라는 함수로 레이아웃 묶어주기
        configureBackgroundImageView()
        configureProfileImageView()
        configureUserNameLabel()
        configureUserAddressLabel()
        configureProfileEditButton()
        configureLikeVideoButton()
        configureLogoutButton()
    }
    
    func configureProfileImageView() {
        view.addSubview(profileImageView)
        view.bringSubviewToFront(profileImageView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 130),
            profileImageView.heightAnchor.constraint(equalToConstant: 130),
            profileImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 180)
        ])
    }
    
    func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.heightAnchor.constraint(equalToConstant: 350), // ImageView 높이
            backgroundImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor), // ImageView 왼쪽 끝에 맞춤
            backgroundImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor), // ImageView 오른쪽 끝에 맞춤
            backgroundImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor) // 중앙 정렬
        ])
    }
    
    func configureUserNameLabel(){
        view.addSubview(userNameLabel)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    func configureUserAddressLabel(){
        view.addSubview(userAddressLabel)
        
        userAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAddressLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 30),
            userAddressLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
            
        ])
    }
    
    func configureProfileEditButton(){
        view.addSubview(profileEditButton)
        
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileEditButton.widthAnchor.constraint(equalToConstant: 360), // 가로 너비
            profileEditButton.heightAnchor.constraint(equalToConstant: 50), // 세로 길이
            profileEditButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 400),
            profileEditButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), // 중앙정렬
        ])
    }
    
    func configureLikeVideoButton(){
        view.addSubview(likeVideoButton)
        
        likeVideoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeVideoButton.widthAnchor.constraint(equalToConstant: 360), // 가로 너비
            likeVideoButton.heightAnchor.constraint(equalToConstant: 50), // 세로 길이
            likeVideoButton.topAnchor.constraint(equalTo: profileEditButton.topAnchor, constant: 70),
            likeVideoButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor) // 중앙정렬
        ])
    }
    
    func configureLogoutButton(){
        view.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalToConstant: 360),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.topAnchor.constraint(equalTo: likeVideoButton.topAnchor, constant: 70),
            logoutButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
}

