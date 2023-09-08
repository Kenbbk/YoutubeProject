//
//  CommentViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/06.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var coommentTextField: UITextField!
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textFieldViewHeightConstraint: NSLayoutConstraint!
    
    var selectedVideoId: String = ""
    
//    init(selectedVideoId: String) {
//        self.selectedVideoId = selectedVideoId
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCommentView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commentTableView.reloadData()
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
        cell.userName.text = comment.userName
        cell.userComment.text = comment.comment
        
        // 이미지 구현 꼭 하기
//        loadImage(urlString: comment.userImageURL, imageView: cell.userImageView)
        
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
