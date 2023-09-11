//
//  CompositionalLayout.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/10.
//

import UIKit

struct CompositionalLayout {
    
    func makeLayout() -> UICollectionViewCompositionalLayout {
        
        let sections: [Section] = [.firstVideos, .firstShorts, .secondVideos, .secondShorts, .thirdVideos]
        
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnviro in
            //            guard let self else { return collectionViewLayout)}
            
            let section = sections[sectionIndex]
            
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
                
                section.boundarySupplementaryItems = [supplementaryHeaderItem()]
                
                return section
                
            }
        }
        
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem    {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
