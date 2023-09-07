//
//  MainVC.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/04.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Properties
    
    let dataManager = DataManager()
    
    let containerView = UIView()
    
    var videoModels: [VideoModel] = []
    
    var collectionVC = MainCollectionVC(collectionViewLayout: UICollectionViewLayout())
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureContainerView()
        addVCS()
        getModels {
            
            self.giveSnapshot()
        }
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
        }
        
        snapshot.appendItems([], toSection: .firstShorts)
        snapshot.appendItems([], toSection: .secondVideos)
        snapshot.appendItems([], toSection: .secondShorts)
        snapshot.appendItems([], toSection: .thirdVideos)
        collectionVC.snapshot = snapshot
    }

    
    private func addVCS() {
        
        add(collectionVC, to: containerView)
        collectionVC.delegate = self
    }
    
    private func configureContainerView() {
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension MainVC: MainCollectionVCDelegate {
    func itemTapped(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.videoModel = videoModels[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
