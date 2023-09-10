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
    
    var videoModels: [VideoModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CompositionalLayout().makeLayout())
        collectionView.register(ShortCell.self, forCellWithReuseIdentifier: ShortCell.identifier)
        collectionView.register(LongCell.self, forCellWithReuseIdentifier: LongCell.identifier)
        collectionView.register(ShortHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShortHeader.identifier)

        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, VideoModel>!
    
    var channelModel: ChannelModel!
    
    let youtubeLogoView = YoutubeLogoView()
    
    var collectionVC: CategoryCollectionVC!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        addVC()
        configureDataSource()
        
        getModels {
            DispatchQueue.main.async {
                self.makeSnapshot()
                self.collectionView.contentInset = .init(top: 80, left: 0, bottom: 0, right: 0)
                self.collectionView.delegate = self
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    
    //MARK: - Actions
    
    
    
    //MARK: - Helpers
    
    private func addVC() {
        collectionVC = CategoryCollectionVC(collectionViewLayout: UICollectionViewFlowLayout())
        add(collectionVC, to: youtubeLogoView.collectionVCContinerView)
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, VideoModel>()
        
        snapshot.appendSections([.firstVideos, .firstShorts, .secondVideos, .secondShorts, .thirdVideos])
        if videoModels.count != 0 {
            snapshot.appendItems([videoModels[0]], toSection: .firstVideos)
            snapshot.appendItems([videoModels[1],videoModels[2],videoModels[3],videoModels[4]], toSection: .firstShorts)
        }
        
        
        snapshot.appendItems([], toSection: .secondVideos)
        snapshot.appendItems([], toSection: .secondShorts)
        snapshot.appendItems([], toSection: .thirdVideos)
        dataSource.apply(snapshot)
    }
    
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
    
    private func configureUI() {
        configureCollectionView()
        configureYoutubeLogoView()
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
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let a = [0, 2, 4]
            if a.contains(indexPath.section) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongCell.identifier, for: indexPath) as! LongCell
                
                cell.play(model: itemIdentifier)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortCell.identifier, for: indexPath)
                cell.backgroundColor = .yellow
                return cell
            }
            
        })
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ShortHeader.identifier, for: indexPath) as? ShortHeader else {
                fatalError("Could not dequeue sectionHeader: \(ShortHeader.identifier)")
            }
            
            return sectionHeader
        }
    }
    
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

extension MainVC: UICollectionViewDelegate {
    
}

extension MainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
       
        if distanceFromBottom < height {
            heightConstraint.constant = 0
        } else if contentYoffset <= -80 {
           
        } else {
            aa()
            updateOffset(offsetY: scrollView.contentOffset.y)
            
        }
        
    }
}
//
//extension MainVC: MainCollectionVCDelegate {
//    func itemTapped(indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
//        dataManager.fetchChannelInfo(channelId: videoModels[indexPath.row].channelId) { result in
//            switch result {
//            case .failure(let failure):
//                print(failure)
//            case .success(let channelModel):
//                self.channelModel = channelModel
//
//
//
//                DispatchQueue.main.async {
//                    let vc = storyboard.instantiateViewController(identifier: "DetailViewController") { coder ->  DetailViewController in
//                        DetailViewController(coder: coder, dataManager: self.dataManager, imageLoader: self.imageLoader, videoModel: self.videoModels[indexPath.row], channelModel: channelModel)!
//
//                    }
//                    vc.videoModel = self.videoModels[indexPath.row]
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true)
//                }
//            }
//        }
//    }

//    func scrollViewDidScrolled(_ scrollView: UIScrollView) {
//        let height = scrollView.frame.size.height
//        let contentYoffset = scrollView.contentOffset.y
//        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//        //        print(UIScreen.main.bounds.height)
//        //        print(distanceFromBottom)
//        if distanceFromBottom < height {
//            heightConstraint.constant = 0
//        } else if contentYoffset <= -80 {
//            //              print(" you reached top of the table")
//            //              updateOffset1(offsetY: scrollView.contentOffset.y)
//        } else {
//            aa()
//            updateOffset(offsetY: scrollView.contentOffset.y)
//            //              print(Int(currentOffsetY), Int(lastPositionY), Int(bottomConstraint.constant))
//        }
//
//
//        //        print(scrollView.contentOffset.y)
//    }
//}
