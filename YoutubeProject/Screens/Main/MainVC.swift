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
            print("get model")
            self.collectionVC.videoModels = self.videoModels
            
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
    
    private func addVCS() {
        
        add(collectionVC, to: containerView)
        
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
