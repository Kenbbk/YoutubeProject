//
//  ViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerTableView: UITableView!
    
    let dataManager = DataManager()
    
    var videos: [VideoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        playerTableView.dataSource = self
        playerTableView.delegate = self
        
        dataManager.delegate = self
        
        dataManager.perforRequest()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 셀 클릭 시 id, title 값 넘겨주며 indexPath.row에 맞는 DetailVC로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = videos[indexPath.row]
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailVC.videoID = selectedVideo.id
            detailVC.videoDate = selectedVideo.publishedAt
            detailVC.videoTitle = selectedVideo.title
            detailVC.videoDescription = selectedVideo.description
            
            detailVC.videoViewCount = selectedVideo.viewCount
            detailVC.videoLikeCount = selectedVideo.likeCount
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        
        cell.textLabel?.text = videos[indexPath.row].title
        
        return cell
    }
}

// MARK: - DataManagerDeleage
extension ViewController: DataManagerDeleage {
    
    // 업데이트를 비동기 처리
    func didUpdateVideos(videos: [VideoModel]) {
        self.videos = videos
        DispatchQueue.main.async {
            self.playerTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("오류: \(error)")
    }
}
