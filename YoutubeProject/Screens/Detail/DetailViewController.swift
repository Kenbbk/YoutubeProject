//
//  DetailViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController, YTPlayerViewDelegate, ImageLoad {
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userComment: UILabel!
    
    @IBOutlet weak var commmentView: UIView!
    
    var channelInfo: ChannelModel?
    
    // 채널 정보
    var channelID: String = ""
    var thumbnailURL: String = ""
    
    // 영상 정보
    
    var videoModel: VideoModel?
    
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDetailView()
        
        playerView.delegate = self
        
        commmentView.layer.borderColor = UIColor.black.cgColor
        commmentView.layer.borderWidth = 0.5
        commmentView.layer.cornerRadius = 20
    }
    
    // 공유 버튼
    @IBAction func shareButton(_ sender: UIButton) {
        let shareText: String = "https://www.youtube.com/watch?v=\(videoModel!.id)"
        var shareObject = [Any]()
        
        shareObject.append(shareText)
        
        let activityVC = UIActivityViewController(activityItems: shareObject, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
    
    
    func updateDetailView() {
        // youtube 영상의 고유 id를 영상으로 변환 후 로드 및 자동재생
        playerView.load(withVideoId: videoModel!.id, playerVars: ["autoplay":1, "modestbranding":1])
        
        videoTitleLabel.text = videoModel!.title
        
        // 타이틀레이블 클릭 시 액션 추가
        videoTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        videoTitleLabel.isUserInteractionEnabled = true
        
        commmentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(commentViewTapped)))
        commmentView.isUserInteractionEnabled = true
        
        dataManager.fetchChannelInfo(channelId: channelID) { [weak self] channelInfo in
            if let channelInfo = channelInfo {
                self?.channelInfo = channelInfo
                self?.updateChannelInfo()
                self?.loadImage(urlString: self!.channelInfo!.thumbnailURL, imageView: self!.thumbnailImage)
            }
        }
        
        //loadImage(urlString: <#T##String#>, imageView: <#T##UIImageView#>)
    }
    
    @objc func commentViewTapped() {
        let commentVC = CommentViewController()
        commentVC.modalPresentationStyle = .pageSheet
        commentVC.modalTransitionStyle = .coverVertical
        
        if let sheet = commentVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            
            sheet.prefersGrabberVisible = true
        }
        
        commentVC.selectedVideoId = videoModel!.id
        
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
        
        descriptionVC.videoDate = videoModel!.publishedAt
        descriptionVC.videoTitle = videoModel!.title
        descriptionVC.videoDescription = videoModel!.description
        
        descriptionVC.videoViewCount = videoModel!.viewCount
        descriptionVC.videoLikeCount = videoModel!.likeCount
        
        present(descriptionVC, animated: true)
    }
    
    func updateChannelInfo() {
        if let channelInfoData = channelInfo {
            let channelName = channelInfoData.title
            let subscriberCount = Formatter.formatLikeCount(channelInfoData.subscriberCount)
            
            let attributedText = NSMutableAttributedString(string: "")
            
            let channelNameText = NSAttributedString(string: channelName + "    ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(channelNameText)
            
            let subscriberText = NSAttributedString(string: subscriberCount, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            attributedText.append(subscriberText)
            
            DispatchQueue.main.async {
                self.channelNameLabel.attributedText = attributedText
                self.channelNameLabel.sizeToFit()
                self.loadImage(urlString: self.channelInfo?.thumbnailURL ?? "", imageView: self.thumbnailImage)
            }
        }
    }
    
//    func loadUrlImage() {
//        if let channelInfoData = channelInfo {
//            let channelImageUrl = channelInfoData.thumbnailURL
//
//            guard let url = URL(string: channelImageUrl) else { return }
//
//            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//                guard let data = data, error == nil else {
//                    print("데이터 가져오기 오류")
//                    return
//                }
//
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.thumbnailImage.image = image
//                        self?.thumbnailImage.layer.cornerRadius = (self?.thumbnailImage.frame.height)! / 2
//                        self?.thumbnailImage.layer.borderWidth = 1
//                        self?.thumbnailImage.layer.borderColor = UIColor.clear.cgColor
//                        self?.thumbnailImage.clipsToBounds = true
//                    }
//                } else {
//                    print("이미지 가져오기 오류")
//                }
//            }
//            // API 요청 시작부분
//            task.resume()
//        }
//    }
}
