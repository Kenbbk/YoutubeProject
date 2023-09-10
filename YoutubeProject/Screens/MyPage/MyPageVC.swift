
import UIKit

class MyPageVC: UIViewController {
    
    //MARK: - Properties
    
    var userRepository: UserRepository
    
    var currentUser: User
    
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
        label.textColor = .white
        
        return label
    }()
    
    let userChannelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    lazy var profileEditButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.addTarget(self, action: #selector(profileEditButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var likeVideoButton: UIButton = {
        let button = UIButton()
        button.setTitle("좋아요 표시한 동영상", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .lightGray.withAlphaComponent(0.7)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.addTarget(self, action: #selector(likeVideoButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .lightGray.withAlphaComponent(0.7)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureUI()
        setUserInfoLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currentUser = userRepository.getCurrentUser()
        setUserInfoLabels()
        print("\(currentUser.firstName), \(userRepository.getCurrentUser().firstName)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        StatusBarChanger().changeStatusBarBgColor(bgColor: .systemBackground)
    }
    
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.currentUser = userRepository.getCurrentUser()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    
    @objc func profileEditButtonTapped(_ button: UIButton){
        let editVC = ProfileEditVC(userRepository: userRepository)
        editVC.delegate = self
        self.present(editVC, animated: true)
    }
    
    @objc func likeVideoButtonTapped(_ button: UIButton){
        let likeVideoVC = LikeVideoVC()
        likeVideoVC.myPageVC = self
        
        // LikeVideoVC로 화면 전환
        self.navigationController?.pushViewController(likeVideoVC, animated: true)
    }
    
    @objc func logoutButtonTapped(_ button: UIButton){
        print("Logout button tapped")
        UserDefaultsManager.shared.logout()
        self.navigationController?.dismiss(animated: true)
      
    }
    
    
    //MARK: - Helper
    
    func setUserInfoLabels(){
        // User 데이터 가지고 오기
        
        userNameLabel.text = "\(currentUser.lastName)\(currentUser.firstName)"
        userChannelNameLabel.text = "@\(currentUser.channelName)"
        
        profileImageView.image = UIImage(data: currentUser.profileImageData)
        
        
        
        backgroundImageView.image = UIImage(data: currentUser.backgroundImageData)
        
        
    }
}

extension MyPageVC: ProfileEditVCDelegate {
    func editButtonTapped() {
        currentUser = userRepository.getCurrentUser()
        setUserInfoLabels()
        print("Hello!@#!@#@!#")
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
        view.addSubview(userChannelNameLabel)
        
        userChannelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userChannelNameLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 30),
            userChannelNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func configureProfileEditButton(){
        view.addSubview(profileEditButton)
        
        profileEditButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileEditButton.widthAnchor.constraint(equalToConstant: 360), // 가로 너비
            profileEditButton.heightAnchor.constraint(equalToConstant: 50), // 세로 길이
            profileEditButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 420),
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


