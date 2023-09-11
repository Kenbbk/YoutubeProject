//
//  CommentViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/06.
//

import UIKit

protocol CommentViewControllerDelegate: AnyObject {
    func dismissTapped(commentText: String)
}

class CommentViewController: UIViewController, UITextFieldDelegate {
    
    private let userRepository: UserRepository
    
    private let user: User
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var coommentTextField: UITextField!
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textFieldViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: CommentViewControllerDelegate?
    
    var selectedVideoId: String = ""
    
    @IBAction func rightButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        if let commentText = coommentTextField.text, !commentText.isEmpty {
            let comment = Comment(userName: userInfoList.userName, userImageURL: userInfoList.userImageURL, comment: commentText)
            
            CommentManager.shared.addComment(comment, videoId: selectedVideoId)
            
            coommentTextField.text = ""
            
            updateTextFieldHeight()
            
            commentTableView.reloadData()
            
            delegate?.dismissTapped(commentText: commentText)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        coommentTextField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coommentTextField.delegate = self
        
        setUpCommentView()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    init(userRepository: UserRepository) {
        self.user = userRepository.getCurrentUser()
        self.userRepository = userRepository
        super.init(nibName: "CommentViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImage() {
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commentTableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
       
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.textFieldView.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    
    @objc func keyboardDown() {
        self.textFieldView.transform = .identity
    }
    
    func setUpCommentView() {
        commentTableView.dataSource = self
        commentTableView.delegate = self
        
        leftButton.isUserInteractionEnabled = false
        
        let userCommentNib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentTableView.register(userCommentNib, forCellReuseIdentifier: "CommentTableViewCell")
    }
    
    func updateTextFieldHeight() {
        let maxHeight: CGFloat = 100.0
        let fixedWidth = coommentTextField.frame.size.width
        let newSize = coommentTextField.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if newSize.height <= maxHeight {
            textFieldViewHeightConstraint.constant = newSize.height
        } else {
            textFieldViewHeightConstraint.constant = maxHeight
        }
        
        view.layoutIfNeeded()
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentManager.shared.getComments(videoId: selectedVideoId).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        
        let comments = CommentManager.shared.getComments(videoId: selectedVideoId)
        
        let comment = comments[indexPath.row]
        
        cell.userName.text = "\(user.lastName)\(user.firstName)"
        cell.userComment.text = comment.comment
        cell.userImageView.image = UIImage(data: user.profileImageData)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let comments = CommentManager.shared.getComments(videoId: selectedVideoId)
        let comment = comments[indexPath.row]
        
        let labelWidth = tableView.frame.width - 16
        let labelFont = UIFont.systemFont(ofSize: 14)
        let labelInsets = UIEdgeInsets(top: 8, left: 8, bottom: 50, right: 8)
        
        let commenText = comment.comment
        let labelSize = commenText.boundingRect(with: CGSize(width: labelWidth - labelInsets.left - labelInsets.right, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: labelFont],context: nil).size
        
        let cellHeight = labelSize.height + labelInsets.top + labelInsets.bottom
        
        return cellHeight
    }
}
