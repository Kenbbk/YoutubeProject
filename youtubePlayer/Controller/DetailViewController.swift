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
    
    var videoID: String = ""
    var videoTitle: String = ""
    var videoDescription: String = ""
    var videoViewCount: String = ""
    var videoLikeCount: String = ""
    var videoDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // youtube 영상의 고유 id를 영상으로 변환 후 로드
        playerView.load(withVideoId: videoID)
        
        videoTitleLabel.text = videoTitle
        
        videoTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        videoTitleLabel.isUserInteractionEnabled = true
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
}
