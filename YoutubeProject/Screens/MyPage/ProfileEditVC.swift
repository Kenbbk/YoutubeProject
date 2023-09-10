
import UIKit

protocol ProfileEditVCDelegate: AnyObject {
    // 수정된 데이터 전달할 델리게이트
    func editButtonTapped()
}

//MARK: - Properties



class ProfileEditVC: UIViewController {
    
    var userRepository: UserRepository
    
    var user: User
    
    let profileImagePicker = UIImagePickerController()
    let backgroundImagePicker = UIImagePickerController()
    
    var profileImage: UIImage!
    var backgroundImage: UIImage!
    
    weak var delegate: ProfileEditVCDelegate?
    lazy var safeArea = view.safeAreaLayoutGuide
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 80
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        
        return imageView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "성"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "채널명"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let addressDataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0)) // 커서 위치 설정
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var channelNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var profileImageEditButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "camera")
        button.setImage(buttonImage, for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .lightGray
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(profileImageEditButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var backgroundImageEditButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "camera")
        button.setImage(buttonImage, for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(backgroundImageEditButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var editCompleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editCompleteButtonTapped(_:)), for: .touchUpInside)
        button.isEnabled = false // 버튼 비활성화 상태로 설정
        
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        profileImagePicker.delegate = self
        backgroundImagePicker.delegate = self
        
        setUserInformation()
        
        
        
        // 이미지 가져오기
        if let profileImage = loadImageFromUserDefaults(forKey: "ProfileImage") {
            profileImageView.image = profileImage
        }
        if let backgroundImage = loadImageFromUserDefaults(forKey: "BackgroundImage") {
            backgroundImageView.image = backgroundImage
        }
        configureUI()
    }
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.user = userRepository.getCurrentUser()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    //MARK: - Actions
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func profileImageEditButtonTapped(_ button: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "앨범에서 가져오기", style: .default) { (action) in self.profileImageLibrary() }
        let remove = UIAlertAction(title: "프로필 사진 삭제하기", style: .default) {
            [weak self] (action) in
            self?.profileImage = nil // 프로필 사진 삭제
            self?.profileImageView.image = UIImage(named: "profile0")
            self?.backgroundImageView.isHidden = false
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(remove)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func backgroundImageEditButtonTapped(_ button: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "앨범에서 가져오기", style: .default) { (action) in self.backgroundImageLibrary() }
        let remove = UIAlertAction(title: "배경 사진 삭제하기", style: .default) {
            [weak self] (action) in
            self?.backgroundImage = nil
            self?.backgroundImageView.image = UIImage(named: "background0")
            self?.backgroundImageView.isHidden = false
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(remove)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func editCompleteButtonTapped(_ button: UIButton) {

        user.firstName = firstNameTextField.text!
        user.lastName = lastNameTextField.text!
        user.channelName = channelNameTextField.text!
        let profileImageData = profileImageView.image?.jpegData(compressionQuality: 1)
        let backgroundImageData = backgroundImageView.image?.jpegData(compressionQuality: 1)
        user.profileImageData = profileImageData
        user.backgroundImageData = backgroundImageData
        
        userRepository.editCurrentUser(user: user)
        UserDefaultsManager.shared.saveUser(user: user)
        // 델리게이트를 통해 데이터 전달
        delegate?.editButtonTapped()
        self.dismiss(animated: true)
    }
     // locaRepository, userdefaultRepository // register 2 저장을 // 로그인 2 페치 // 1번에 저장 // edit 1번에 변경정보 저장 // default 저장을 해요
    // 1
    
    
    //MARK: - Helper
    
    private func setUserInformation() {

        channelNameTextField.text = user.channelName
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        if let profileimageData = user.profileImageData {
            profileImageView.image = UIImage(data: profileimageData)
        }
        if let backgroundImageData = user.backgroundImageData {
            backgroundImageView.image = UIImage(data: backgroundImageData)
        }
        
        
        
        
    }
    
    func textFieldDeselectTapGesture() {
        // 화면의 다른 부분을 탭할 때 커서 사라지게 하기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func updateTextFieldBorderStyle() {
        let firstNameIsEmpty = firstNameTextField.text?.isEmpty ?? true
        let lastNameIsEmpty = lastNameTextField.text?.isEmpty ?? true
        let addressIsEmpty = channelNameTextField.text?.isEmpty ?? true
        // TextField 활성화일 때 Button Color 지정
        editCompleteButton.isEnabled = !firstNameIsEmpty && !lastNameIsEmpty && !addressIsEmpty
        editCompleteButton.backgroundColor = editCompleteButton.isEnabled ? .systemRed : .lightGray
    }
    
    func profileImageLibrary(){
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: false, completion: nil)
    }
    
    func backgroundImageLibrary(){
        backgroundImagePicker.sourceType = .photoLibrary
        present(backgroundImagePicker, animated: false, completion: nil)
    }
    
    
    // UserDefaults에서 이미지 데이터를 불러오는 함수
    func loadImageFromUserDefaults(forKey key: String) -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: imageData)
        }
        return nil
    }
}


//MARK: - TextField Delegate

extension ProfileEditVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TextField 활성화일 때 Border Color 지정
        textField.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // TextField 비활성화일 때 Border Color 지정
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let firstName = firstNameTextField.text, !firstName.isEmpty,
           let lastName = lastNameTextField.text, !lastName.isEmpty,
           let address = channelNameTextField.text, !address.isEmpty {
            editCompleteButton.isEnabled = true
            editCompleteButton.backgroundColor = .systemRed
        } else {
            editCompleteButton.isEnabled = false
            editCompleteButton.backgroundColor = .lightGray
        }
        
        let currentText = textField.text ?? ""
        let addressEdit = (currentText as NSString).replacingCharacters(in: range, with: string)
        addressDataLabel.text = "@\(addressEdit)"
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileEditVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 프로필 편집 버튼을 눌렀을 때 프로필 이미지 업데이트
            if picker == profileImagePicker {
                profileImage = selectedImage
                profileImageView.image = selectedImage
                profileImageView.contentMode = .scaleAspectFill
            } else {
                backgroundImage = selectedImage
                backgroundImageView.image = selectedImage
                backgroundImageView.contentMode = .scaleAspectFill
            }
        }
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - UI

extension ProfileEditVC {
    
    func configureUI() {
        textFieldDeselectTapGesture()
        configureBackgroundImageView()
        configureProfileImageView()
        configureProfileImageEditButton()
        configureBackgroundImageEditButton()
        configureFirstNameLabel()
        configureFirstNameTextField()
        configureLastNameLabel()
        configureLastNameTextField()
        configureAddressLabel()
        configureAddressTextField()
        configureAddressDataLabel()
        configureEditCompleteButton()
    }
    
    
    
    //MARK: - ImageView
    func configureProfileImageView(){
        view.addSubview(profileImageView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 160),
            profileImageView.heightAnchor.constraint(equalToConstant: 160),
            profileImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 110)
        ])
    }
    
    func configureBackgroundImageView(){
        view.addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 195)
        ])
    }
    
    //MARK: - Label
    func configureFirstNameLabel(){
        view.addSubview(firstNameLabel)
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameLabel.widthAnchor.constraint(equalToConstant: 330),
            firstNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 60),
            firstNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func configureLastNameLabel(){
        view.addSubview(lastNameLabel)
        
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastNameLabel.widthAnchor.constraint(equalToConstant: 330),
            lastNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 25),
            lastNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func configureAddressLabel(){
        view.addSubview(addressLabel)
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.widthAnchor.constraint(equalToConstant: 330),
            addressLabel.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 25),
            addressLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func configureAddressDataLabel(){
        view.addSubview(addressDataLabel)
        
        addressDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressDataLabel.widthAnchor.constraint(equalToConstant: 330),
            addressDataLabel.topAnchor.constraint(equalTo: channelNameTextField.bottomAnchor, constant: 5),
            addressDataLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    //MARK: - TextField
    func configureFirstNameTextField(){
        view.addSubview(firstNameTextField)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameTextField.widthAnchor.constraint(equalToConstant: 340),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 10),
            firstNameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func configureLastNameTextField(){
        view.addSubview(lastNameTextField)
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastNameTextField.widthAnchor.constraint(equalToConstant: 340),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 10),
            lastNameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    func configureAddressTextField(){
        view.addSubview(channelNameTextField)
        
        channelNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelNameTextField.widthAnchor.constraint(equalToConstant: 340),
            channelNameTextField.heightAnchor.constraint(equalToConstant: 50),
            channelNameTextField.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            channelNameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
            
        ])
    }
    
    //MARK: - Button
    func configureProfileImageEditButton(){
        view.addSubview(profileImageEditButton)
        
        profileImageEditButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageEditButton.widthAnchor.constraint(equalToConstant: 50),
            profileImageEditButton.heightAnchor.constraint(equalToConstant: 50),
            profileImageEditButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 50),
            profileImageEditButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 60)
        ])
    }
    
    func configureBackgroundImageEditButton(){
        view.addSubview(backgroundImageEditButton)
        
        backgroundImageEditButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageEditButton.widthAnchor.constraint(equalToConstant: 30),
            backgroundImageEditButton.heightAnchor.constraint(equalToConstant: 30),
            backgroundImageEditButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            backgroundImageEditButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -15)
        ])
    }
    
    
    func configureEditCompleteButton(){
        view.addSubview(editCompleteButton)
        
        editCompleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editCompleteButton.widthAnchor.constraint(equalToConstant: 340),
            editCompleteButton.heightAnchor.constraint(equalToConstant: 50),
            editCompleteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            editCompleteButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
}

// 1.회원가입할때 유저를 만들고 유저를 저장 2. 로그인페이지로가서 그 저장된 유저의 이메일로 로그인. 3. 누가 지금 로그인되어있는가에 관한 파일을 만든다 4. 이걸 바꾼다 그러면 유저디폴트에 값을 수정해준다. 5. 로컬 유저값도 바꿔준다
// 6. 로그아웃을 했을때 로그아웃을 시켜준다
