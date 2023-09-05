//
//  DetailViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController {
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    var channelInfo: ChannelModel?
    
    var channelID: String = ""
    
    var thumbnailURL: String = ""
    
    var videoID: String = ""
    var videoTitle: String = ""
    var videoDescription: String = ""
    var videoViewCount: String = ""
    var videoLikeCount: String = ""
    var videoDate: String = ""
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // youtube 영상의 고유 id를 영상으로 변환 후 로드
        playerView.load(withVideoId: videoID)
        
        videoTitleLabel.text = videoTitle
        
        videoTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        videoTitleLabel.isUserInteractionEnabled = true
        
        dataManager.fetchChannelInfo(channelId: channelID) { [weak self] channelInfo in
            if let channelInfo = channelInfo {
                self?.channelInfo = channelInfo
                self?.updateChannelInfo()
                self?.loadUrlImage()
            }
        }
    }
    
    @objc func labelTapped() {
        let descriptionVC = DescriptionViewController()
        descriptionVC.modalPresentationStyle = .pageSheet
        descriptionVC.modalTransitionStyle = .coverVertical
        
        if let sheet = descriptionVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            
            sheet.prefersGrabberVisible = true
        }
        
        descriptionVC.videoDate = videoDate
        descriptionVC.videoTitle = videoTitle
        descriptionVC.videoDescription = videoDescription
        
        descriptionVC.videoViewCount = videoViewCount
        descriptionVC.videoLikeCount = videoLikeCount
        
        present(descriptionVC, animated: true)
    }
    
    func updateChannelInfo() {
        if let channelInfoData = channelInfo {
            let channelName = channelInfoData.title
            let subscriberCount = Formatter.formatLikeCount(channelInfoData.subscriberCount)
            
            let attributedText = NSMutableAttributedString(string: "")
            
            let channelNameText = NSAttributedString(string: channelName + "    ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
            attributedText.append(channelNameText)
            
            let subscriberText = NSAttributedString(string: subscriberCount, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            attributedText.append(subscriberText)
            
            DispatchQueue.main.async {
                self.channelNameLabel.attributedText = attributedText
                self.channelNameLabel.sizeToFit()
                self.loadUrlImage()
            }
        }
    }
    
    func loadUrlImage() {
        if let channelInfoData = channelInfo {
            let channelImageUrl = channelInfoData.thumbnailURL
            
            guard let url = URL(string: channelImageUrl) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("데이터 가져오기 오류")
                    return
                }
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.thumbnailImage.image = image
                        self?.thumbnailImage.layer.cornerRadius = (self?.thumbnailImage.frame.height)! / 2
                        self?.thumbnailImage.layer.borderWidth = 1
                        self?.thumbnailImage.layer.borderColor = UIColor.clear.cgColor
                        self?.thumbnailImage.clipsToBounds = true
                    }
                } else {
                    print("이미지 가져오기 오류")
                }
            }
            // API 요청 시작부분
            task.resume()
        }
    }
}
