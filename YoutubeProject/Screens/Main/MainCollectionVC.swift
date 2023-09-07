//
//  MainCollectionVC.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import UIKit

enum Section {
    case firstVideos
    case secondVideos
    case firstShorts
    case secondShorts
    case thirdVideos
}

private let reuseIdentifier = "Cell"

class MainCollectionVC: UICollectionViewController {
    
    let sections: [Section] = [.firstVideos, .firstShorts, .secondVideos, .secondShorts, .thirdVideos]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, VideoModel>!
    
    var videoModels: [VideoModel] = [] {
        didSet {
            applySanpshot()
            print("I am called")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        applySanpshot()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeFromParent()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        
        collectionView.register(ShortCell.self, forCellWithReuseIdentifier: ShortCell.identifier)
        collectionView.register(LongCell.self, forCellWithReuseIdentifier: LongCell.identifier)
        collectionView.register(ShortHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShortHeader.identifier)
        
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
    
    private func applySanpshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, VideoModel>()
        
        snapshot.appendSections([.firstVideos, .firstShorts, .secondVideos, .secondShorts, .thirdVideos])
        if videoModels.count != 0 {
            snapshot.appendItems([videoModels[0]], toSection: .firstVideos)
        }
        
        snapshot.appendItems([], toSection: .firstShorts)
        snapshot.appendItems([], toSection: .secondVideos)
        snapshot.appendItems([], toSection: .secondShorts)
        snapshot.appendItems([], toSection: .thirdVideos)
        dataSource.apply(snapshot)
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem    {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { [ weak self ] sectionIndex, layoutEnviro in
            //            guard let self else { return collectionViewLayout)}
            
            let section = self!.sections[sectionIndex]
            print("working")
            switch section {
            case .firstVideos, .secondVideos, .thirdVideos:
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(317)), repeatingSubitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.interGroupSpacing = 10
                
                return section
                
            case .firstShorts, .secondShorts:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.35)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 0, leading: 9, bottom: 25, trailing: 19)
                
                section.boundarySupplementaryItems = [self!.supplementaryHeaderItem()]
                
                return section
                
            }
        }
        
    }
    
    
    
}
