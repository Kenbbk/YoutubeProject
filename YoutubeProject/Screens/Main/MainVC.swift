//
//  MainVC.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Properties
    
    var lastPositionY: CGFloat = 0
    var currentOffsetY: CGFloat = 0
    var heightConstraint: NSLayoutConstraint!
    
    let dataManager = DataManager()
    
    let imageLoader = ImageLoader()
    
    let containerView = UIView()
    
    var videoModels: [VideoModel] = []
    
    private lazy var collectionVC: MainCollectionVC = {
        let collectionVC = MainCollectionVC(collectionViewLayout: CompositionalLayout().makeLayout())
        collectionVC.collectionView.contentInset = .init(top: 80, left: 0, bottom: 0, right: 0)
        collectionVC.delegate = self
        return collectionVC
    }()
    
    var channelModel: ChannelModel!
    
    let youtubeLogoView = YoutubeLogoView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        addVCS()
        getModels {
            print("get models get called")
            self.giveSnapshot()
        }
//        getModels {
//            self.addVCS()
//            print("get models get called")
//            self.giveSnapshot()
//        }
    }
    
    //MARK: - Actions
    
    
    
    //MARK: - Helpers
    
    private func getModels(completion: @escaping () -> Void) {
        dataManager.performRequest { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let videoModels):
                self.videoModels = videoModels
                completion()
            }
        }
    }
    
    private func giveSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, VideoModel>()
        
        snapshot.appendSections([.firstVideos, .firstShorts, .secondVideos, .secondShorts, .thirdVideos])
        if videoModels.count != 0 {
            snapshot.appendItems([videoModels[0]], toSection: .firstVideos)
            snapshot.appendItems([videoModels[1],videoModels[2],videoModels[3],videoModels[4]], toSection: .firstShorts)
        }
        
        
        snapshot.appendItems([], toSection: .secondVideos)
        snapshot.appendItems([], toSection: .secondShorts)
        snapshot.appendItems([], toSection: .thirdVideos)
        collectionVC.snapshot = snapshot
    }
    
    private func configureUI() {
        configureContainerView()
        configureYoutubeLogoView()
    }
    
    private func addVCS() {
        
        add(collectionVC, to: containerView)
    }
    
    
    
    private func configureYoutubeLogoView() {
        view.addSubview(youtubeLogoView)
        youtubeLogoView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = youtubeLogoView.heightAnchor.constraint(equalToConstant: 80)
        NSLayoutConstraint.activate([
            youtubeLogoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            youtubeLogoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            youtubeLogoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightConstraint
            
        ])
    }
    
    
    private func configureContainerView() {
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        
    }
    
    //    private func updateChannelInfo(channelId: String, completion: @escaping (Result<ChannelModel, VideoError>) -> Void) {
    //        dataManager.fetchChannelInfo(channelId: channelId) { result in
    //            switch result {
    //            case .success(let channelModel):
    //                self.channelModel = channelModel
    //            case .failure(let failure):
    //                print(failure)
    //            }
    //        }
    //    }
    
    func updateOffset(offsetY: CGFloat) {
        guard offsetY != 0 else { return }
        guard offsetY > -80 else { return }
        let diff = lastPositionY - offsetY
        self.currentOffsetY = currentOffsetY + diff
       
        if offsetY == 0 {
            
        } else {
            currentOffsetY = min(80, currentOffsetY)
            currentOffsetY = max(0, currentOffsetY)
        }
        
        if offsetY == 0 {
            
        } else {
            heightConstraint.constant = currentOffsetY
        }
        print(heightConstraint.constant)
        
        lastPositionY = offsetY
        
    }
    
    func aa() {
        guard lastPositionY == 0 else { return }
        lastPositionY = youtubeLogoView.frame.origin.y
    }
}

extension MainVC: MainCollectionVCDelegate {
    func itemTapped(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        dataManager.fetchChannelInfo(channelId: videoModels[indexPath.row].channelId) { result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let channelModel):
                self.channelModel = channelModel
                
                //        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                
                DispatchQueue.main.async {
                    let vc = storyboard.instantiateViewController(identifier: "DetailViewController") { coder ->  DetailViewController in
                        DetailViewController(coder: coder, dataManager: self.dataManager, imageLoader: self.imageLoader, videoModel: self.videoModels[indexPath.row], channelModel: channelModel)!
                        
                    }
                    vc.videoModel = self.videoModels[indexPath.row]
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
    }
    
    func scrollViewDidScrolled(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
          let contentYoffset = scrollView.contentOffset.y
          let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//        print(UIScreen.main.bounds.height)
//        print(distanceFromBottom)
          if distanceFromBottom < height {
              heightConstraint.constant = 0
          } else if contentYoffset <= -80 {
//              print(" you reached top of the table")
//              updateOffset1(offsetY: scrollView.contentOffset.y)
          } else {
              aa()
              updateOffset(offsetY: scrollView.contentOffset.y)
//              print(Int(currentOffsetY), Int(lastPositionY), Int(bottomConstraint.constant))
          }

        
//        print(scrollView.contentOffset.y)
    }
}
