//
//  MainVC.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Properties
    
    let userRepository: UserRepository
    
    var user: User
    var lastPositionY: CGFloat = 0
    var currentOffsetY: CGFloat = 0
    var heightConstraint: NSLayoutConstraint!
    
    let dataManager: DataManager
    
    let imageLoader: ImageLoader
    
    var videoModels: [VideoModel] = []
    
    var shortVidoeModels: [VideoModel] = []
    var formattedVideoModels: [[VideoModel]] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CompositionalLayout().makeLayout())
        collectionView.register(ShortCell.self, forCellWithReuseIdentifier: ShortCell.identifier)
        collectionView.register(LongCell.self, forCellWithReuseIdentifier: LongCell.identifier)
        collectionView.register(ShortHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShortHeader.identifier)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, VideoModel>!
    
    var channelModel: ChannelModel!
    
    private lazy var youtubeLogoView: YoutubeCollapsableView = {
        let view = YoutubeCollapsableView()
        view.delegate = self
        return view
    }()
    
    
    var collectionVC: CategoryCollectionVC!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        addVC()
        configureDataSource()
        
        getModels {
            self.formattedVideoModels = DataFormatter().makeLongVideos(models: self.videoModels)
            self.dataManager.performRequest(categoryId: "20") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let videomodels):
                    self.shortVidoeModels = videomodels

                    DispatchQueue.main.async {
                        self.makeSnapshot()
                        self.collectionView.contentInset = .init(top: 80, left: 0, bottom: 0, right: 0)
                        self.collectionView.delegate = self
                        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                    }
                }
            }

        }
    }
    
    init(userRepository: UserRepository, dataManager: DataManager, imageLoader: ImageLoader) {
        self.userRepository = userRepository
        self.dataManager = dataManager
        self.imageLoader = imageLoader
        self.user = userRepository.getCurrentUser()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = userRepository.getCurrentUser()
        changeStatusBarBgColor(bgColor: .white)
        setImage()
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
        
        snapshot.appendItems(formattedVideoModels[0], toSection: .firstVideos)
        snapshot.appendItems(formattedVideoModels[1], toSection: .secondVideos)
        snapshot.appendItems(formattedVideoModels[2], toSection: .thirdVideos)
        print(shortVidoeModels.count)
        
        snapshot.appendItems([shortVidoeModels[1],shortVidoeModels[2],shortVidoeModels[3],shortVidoeModels[4]], toSection: .firstShorts)
        snapshot.appendItems([shortVidoeModels[5],shortVidoeModels[6],shortVidoeModels[7],shortVidoeModels[8]], toSection: .secondShorts)
        dataSource.apply(snapshot)
    }
    
    private func setImage() {
        if let profileImageData = user.profileImageData {
            youtubeLogoView.logoSectionView.profileImageView.image = UIImage(data: profileImageData)
        }
    }
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let statusBarManager = window?.windowScene?.statusBarManager
            
            let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
            statusBarView.backgroundColor = bgColor
            
            window?.addSubview(statusBarView)
        } else {
            let statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
            statusBarView?.backgroundColor = bgColor
        }
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortCell.identifier, for: indexPath) as! ShortCell
                cell.setImage(model: itemIdentifier)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        dataManager.fetchChannelInfo(channelId: videoModels[indexPath.row].channelId) { result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let channelModel):
                self.channelModel = channelModel
                
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



extension MainVC: YoutubeLogoViewDelegate {
    func logoTappedFromCollapsableView(on logo: YoutubeLogos) {
        print(logo)
    }
}

