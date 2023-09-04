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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // youtube 영상의 고유 id를 영상으로 변환 후 로드
        playerView.load(withVideoId: videoID)
        
        videoTitleLabel.text = videoTitle
        
        //videoTitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(<#T##@objc method#>)))
        //videoTitleLabel.isUserInteractionEnabled = true
    }
}
