//
//  DetailViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userComment: UILabel!
    
    @IBOutlet weak var commmentView: UIView!
    
    // 채널 정보
    var channelModel: ChannelModel
    
    // 영상 정보
    var videoModel: VideoModel
    
    
    private let userRepository: UserRepository
    private let user: User
    
    let dataManager: DataManager
    let imageLoader: ImageLoader

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    required init?(coder: NSCoder, dataManager: DataManager, imageLoader: ImageLoader, videoModel: VideoModel, channelModel: ChannelModel, userRepository: UserRepository) {
        self.dataManager = dataManager
        self.imageLoader = imageLoader
        self.videoModel = videoModel
        self.channelModel = channelModel
        self.userRepository = userRepository
        self.user = userRepository.getCurrentUser()
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDetailView()
        updateChannelInfo()
        
        playerView.delegate = self
        
        setUpUi()
    }
    
    func setUpUi() {
        userComment.text = videoModel.commentList.first?.comment
        userImageView.image = UIImage(data: user.profileImageData)
//        imageLoader.loadImage(urlString: channelModel.thumbnailURL) { result in
//            switch result {
//            case .success(let userImageURL):
//                if userImageURL != nil {
//                    DispatchQueue.main.async {
//                        self.userImageView.image = userImageURL
//                    }
//                } else {
//                    print("이미지 없음")
//                }
//            case .failure(let error):
//                print(error)
//            }
        
        
        thumbnailImage.layer.cornerRadius = thumbnailImage.frame.height / 2
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.contentMode = .scaleToFill
        commmentView.layer.borderColor = UIColor.black.cgColor
        commmentView.layer.borderWidth = 0.5
        commmentView.layer.cornerRadius = 35
    }
    
    // 공유 버튼
    @IBAction func shareButton(_ sender: UIButton) {
        let shareText: String = "https://www.youtube.com/watch?v=\(videoModel.id)"
        var shareObject = [Any]()
        
        shareObject.append(shareText)
        
        let activityVC = UIActivityViewController(activityItems: shareObject, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
    
    
    func updateDetailView() {
        // youtube 영상의 고유 id를 영상으로 변환 후 로드 및 자동재생
        playerView.load(withVideoId: videoModel.id, playerVars: ["autoplay":1, "modestbranding":1])
        
        videoTitleLabel.text = videoModel.title
        
        // 타이틀레이블 클릭 시 액션 추가
        videoTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        videoTitleLabel.isUserInteractionEnabled = true
        
        commmentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentViewTapped)))
        commmentView.isUserInteractionEnabled = true
        
        dataManager.fetchChannelInfo(channelId: channelModel.channelId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let channelInfo):
                self?.channelModel = channelInfo
            }
        }
    }
    
    
    
    @objc func commentViewTapped() {
        let commentVC = CommentViewController(userRepository: userRepository)
        commentVC.modalPresentationStyle = .pageSheet
        commentVC.modalTransitionStyle = .coverVertical

        if let sheet = commentVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]

            sheet.prefersGrabberVisible = true
        }
        
        commentVC.selectedVideoId = videoModel.id
        
        commentVC.delegate = self

        present(commentVC, animated: true)
    }
    
    @objc func labelTapped() {
        let descriptionVC = DescriptionViewController()
        descriptionVC.modalPresentationStyle = .pageSheet
        descriptionVC.modalTransitionStyle = .coverVertical
        
        if let sheet = descriptionVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            
            sheet.prefersGrabberVisible = true
        }
        
        descriptionVC.videoDate = videoModel.publishedAt
        descriptionVC.videoTitle = videoModel.title
        descriptionVC.videoDescription = videoModel.description
        
        descriptionVC.videoViewCount = videoModel.viewCount
        descriptionVC.videoLikeCount = videoModel.likeCount
        
        present(descriptionVC, animated: true)
    }
    
    func updateChannelInfo() {
        let channelName = channelModel.title
        let subscriberCount = Formatter.formatLikeCount(channelModel.subscriberCount)
        
        let attributedText = NSMutableAttributedString(string: "")
        
        let channelNameText = NSAttributedString(string: channelName + "    ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(channelNameText)
        
        let subscriberText = NSAttributedString(string: subscriberCount, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedText.append(subscriberText)
        
        self.channelNameLabel.attributedText = attributedText
        self.channelNameLabel.sizeToFit()
        imageLoader.loadImage(urlString: channelModel.thumbnailURL) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.thumbnailImage.image = image
                }
            }
        }
    }
}

extension DetailViewController: CommentViewControllerDelegate {
    func dismissTapped(commentText: String) {
        self.userComment.text = commentText
    }
}
