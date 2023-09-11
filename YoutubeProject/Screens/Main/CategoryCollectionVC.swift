//
//  CategoryCollectionVC.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/10.
//

import UIKit

class CategoryCollectionVC: UICollectionViewController {
    
    let categories = ["All","New to you","Gaming","News","History","Computer programming","Air force","Infilders","Live","Game shows","Variety shows","Media theories","Basketball","Cooking shows","Restaurants","Championships","Thrillers","BodyBuilding","K-pop", "Recently uploaded"]
    
//    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
//        configureDataSource()
    }
    
    private func configureCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        flowLayout.scrollDirection = .horizontal
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 0)
    }
    
//    private func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//
//            return cell
//        })
//    }
   
    //MARK: - dataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.label.text = categories[indexPath.row]
        return cell
    }
    
    //MARK: - delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}




extension CategoryCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                return .zero
            }
        cell.label.text = categories[indexPath.row]
            // ✅ sizeToFit() : 텍스트에 맞게 사이즈가 조절
            cell.label.sizeToFit()

            // ✅ cellWidth = 글자수에 맞는 UILabel 의 width + 20(여백)
            let cellWidth = cell.label.frame.width + 20
        
            return CGSize(width: cellWidth, height: 30)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 1
       }

       // 옆 간격
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }

       // cell 사이즈( 옆 라인을 고려하여 설정 )
    }
