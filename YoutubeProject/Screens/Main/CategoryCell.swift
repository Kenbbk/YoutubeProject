//
//  CategoryCell.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/10.
//

import UIKit

class CategoryCell: UICollectionViewCell{
    
    static let identifier = "CategoryCell"
    
    
    // d
    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.backgroundColor = .black
                label.textColor = .white
                
                print(isSelected, label.text)
                
            } else {
                label.backgroundColor = .systemGray6
                
                label.textColor = .black
                print(isSelected, label.text)
            }
        }
    }
    
    
    let label: UILabel = {
       let label = UILabel()
        label.backgroundColor = .systemGray5
        label.textAlignment = .center
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 10
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    private func configureUI() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    
}
