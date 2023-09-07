
import UIKit

protocol SendDataDelegate: AnyObject {
    // 수정된 데이터 전달할 델리게이트
    func didEditUserInfo(data: User)
}

//MARK: - Properties

class ProfileEditVC: UIViewController {
    var userInfo: User?
    var myPageVC = MyPageVC()
    let profileImagePicker = UIImagePickerController()
    let backgroundImagePicker = UIImagePickerController()
    
    var profileImage: UIImage!
    var backgroundImage: UIImage!
    
    weak var delegate: SendDataDelegate?
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
        imageView.alpha = 0.5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "성"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "채널명"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let addressDataLabel: UILabel = {
        let label = UILabel()
        label.text = "@"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0)) // 커서 위치 설정
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var profileImageEditButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "camera")
        button.setImage(buttonImage, for: .normal)
        button.setTitle("", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
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
        button.tintColor = .lightGray
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
        view.backgroundColor = .white
        profileImagePicker.delegate = self
        backgroundImagePicker.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        addressTextField.delegate = self
        
        // 이미지 가져오기
        if let profileImage = profileImage {
            profileImageView.image = profileImage
        }
        if let backgroundImage = backgroundImage {
            backgroundImageView.image = backgroundImage
        }
        configureUI()
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
    
    @objc func editCompleteButtonTapped(_ button: UIButton){
        // 데이터 수정 값 받아오기
        let editedData = User(id: "user1", firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", address: addressTextField.text ?? "", password: "1234", profileImage: profileImageView.image!, backgroundImage: backgroundImageView.image!)
        // 델리게이트를 통해 데이터 전달
        delegate?.didEditUserInfo(data: editedData)
        
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Helper
    
    func textFieldDeselectTapGesture() {
        // 화면의 다른 부분을 탭할 때 커서 사라지게 하기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func updateTextFieldBorderStyle() {
        let firstNameIsEmpty = firstNameTextField.text?.isEmpty ?? true
        let lastNameIsEmpty = lastNameTextField.text?.isEmpty ?? true
        let addressIsEmpty = addressTextField.text?.isEmpty ?? true
        // TextField 활성화일 때 Button Color 지정
        editCompleteButton.isEnabled = !firstNameIsEmpty && !lastNameIsEmpty && !addressIsEmpty
        editCompleteButton.backgroundColor = editCompleteButton.isEnabled ? .systemBlue : .lightGray
    }
    
    func profileImageLibrary(){
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: false, completion: nil)
    }
    
    func backgroundImageLibrary(){
        backgroundImagePicker.sourceType = .photoLibrary
        present(backgroundImagePicker, animated: false, completion: nil)
    }
    
}


//MARK: - TextField Delegate

extension ProfileEditVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TextField 활성화일 때 Border Color 지정
        textField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // TextField 비활성화일 때 Border Color 지정
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let firstName = firstNameTextField.text, !firstName.isEmpty,
           let lastName = lastNameTextField.text, !lastName.isEmpty,
           let address = addressTextField.text, !address.isEmpty {
            editCompleteButton.isEnabled = true
            editCompleteButton.backgroundColor = .systemBlue
        } else {
            editCompleteButton.isEnabled = false
            editCompleteButton.backgroundColor = .lightGray
        }
        
        let currentText = textField.text ?? ""
        let address = (currentText as NSString).replacingCharacters(in: range, with: string)
        addressDataLabel.text = "@\(address)"
        return true
    }
}


extension ProfileEditVC: SendDataDelegate{
    func didEditUserInfo(data: User) {
        // User 모델에 수정된 데이터 저장
        self.firstNameTextField.text = data.firstName
        self.lastNameTextField.text = data.lastName
        self.addressTextField.text = data.address
        self.profileImage = data.profileImage
        self.backgroundImage = data.backgroundImage
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
            addressDataLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 5),
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
        view.addSubview(addressTextField)
        
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressTextField.widthAnchor.constraint(equalToConstant: 340),
            addressTextField.heightAnchor.constraint(equalToConstant: 50),
            addressTextField.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            addressTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
            
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
