//
//  ShortsHeader.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import UIKit

class ShortHeader: UICollectionReusableView {
    
    static let identifier = "ShortHeader"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        
        
        iv.image = UIImage(named: "shortsIcon1")
        
        return iv
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "Shorts"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        configureImageView()
        configureLabel()

    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
