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



protocol MainCollectionVCDelegate: AnyObject {
    func itemTapped(indexPath: IndexPath)
    func scrollViewDidScrolled(_ scrollView: UIScrollView )
}

class MainCollectionVC: UICollectionViewController {
    
    weak var delegate: MainCollectionVCDelegate?
    
    let sections: [Section] = [.firstVideos, .firstShorts, .secondVideos, .secondShorts, .thirdVideos]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, VideoModel>!
    
    var snapshot: NSDiffableDataSourceSnapshot<Section, VideoModel>!
        {
            didSet {
                dataSource.apply(snapshot)
            }
}
    
   override func viewDidLoad() {
        super.viewDidLoad()
       print("I am init")
        configureCollectionView()
        configureDataSource()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeFromParent()
    }
    
    private func configureCollectionView() {
        
        
       
        
        collectionView.register(ShortCell.self, forCellWithReuseIdentifier: ShortCell.identifier)
        collectionView.register(LongCell.self, forCellWithReuseIdentifier: LongCell.identifier)
        collectionView.register(ShortHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShortHeader.identifier)
        
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            
            
            let a = [0, 2, 4]
            if a.contains(indexPath.section) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongCell.identifier, for: indexPath) as! LongCell
                cell.load(model: itemIdentifier)
                
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
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem    {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemTapped(indexPath: indexPath)
    }
    
    
}

extension MainCollectionVC {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        delegate?.scrollViewDidScrolled(scrollView)
    }
}


