//
//  ShortCell.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import UIKit

class ShortCell: UICollectionViewCell {
    
    static let identifier = "ShortCell"
    
    private var imageView: UIImageView = {
       let iv = UIImageView()
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSelf()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func configureSelf() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    private func configureUI() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setImage(model: VideoModel) {
        ImageLoader().loadImage(urlString: model.thumbnails) { result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {

                    self.imageView.image = image
                }

            }
        }
        
    }
}

//

