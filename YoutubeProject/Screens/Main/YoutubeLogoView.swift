//
//  YoutubeLogoView.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/09.
//

import UIKit

class YoutubeLogoView: UIView {
    
    let upperContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        view.backgroundColor = .brown
        return view
    }()
    
    let squareImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    let bellImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        
        return iv
    }()
    
    let searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    let collectionVCContinerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        collectionVCContinerView.backgroundColor = .brown
        addSubViews()
        configureCollectionVCContainerView()
        configureUpperContainerView()
        configureStackView()
        
    }
    
    
    
    private func addSubViews() {
        [upperContainerView, collectionVCContinerView].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
   private func configureCollectionVCContainerView() {
       NSLayoutConstraint.activate([
        collectionVCContinerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        collectionVCContinerView.leadingAnchor.constraint(equalTo: leadingAnchor),
        collectionVCContinerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        collectionVCContinerView.heightAnchor.constraint(equalToConstant: 40)
       ])
    }
    
    private func configureUpperContainerView() {
        NSLayoutConstraint.activate([
            upperContainerView.bottomAnchor.constraint(equalTo: collectionVCContinerView.topAnchor),
            upperContainerView.leadingAnchor.constraint(equalTo: collectionVCContinerView.leadingAnchor),
            upperContainerView.trailingAnchor.constraint(equalTo: collectionVCContinerView.trailingAnchor),
            upperContainerView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureStackView() {
        upperContainerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: upperContainerView.topAnchor, constant: 5),
            
            stackView.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: upperContainerView.bottomAnchor, constant: -5),
            stackView.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        [squareImageView, bellImageView, searchImageView, profileImageView].forEach { imageView in
            stackView.addArrangedSubview(imageView)
            
        }
    }
    
}
