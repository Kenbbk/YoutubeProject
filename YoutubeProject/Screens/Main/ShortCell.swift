//
//  ShortCell.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import UIKit

class ShortCell: UICollectionViewCell {
    
    static let identifier = "ShortCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
