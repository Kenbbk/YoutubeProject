//
//  YoutubeLogoView.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/09.
//

import UIKit

protocol YoutubeLogoViewDelegate: AnyObject {
    func logoTappedFromCollapsableView(on logo: YoutubeLogos)
}

class YoutubeCollapsableView: UIView {
    
    weak var delegate: YoutubeLogoViewDelegate?
    
    let upperContainerView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    private lazy var logoSectionView: MainLogosView = {
        let view = MainLogosView()
        view.delegate = self
        return view
    }()
    
  
    
    lazy var logoImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "youtubeLogo")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainYoutubeLogoTapped)))
        return iv
    }()
    
    let collectionVCContinerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func mainYoutubeLogoTapped() {
        delegate?.logoTappedFromCollapsableView(on: .main)
    }
    
    
    
    private func configureUI() {
        self.isUserInteractionEnabled = true
        collectionVCContinerView.backgroundColor = .brown
        addSubViews()
        configureCollectionVCContainerView()
        configureUpperContainerView()
        configureLogoImageView()
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
    
    private func configureLogoImageView() {
        upperContainerView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: upperContainerView.bottomAnchor, constant: -7.5),
            logoImageView.leadingAnchor.constraint(equalTo: upperContainerView.leadingAnchor, constant: 10),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            logoImageView.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func configureStackView() {
        upperContainerView.addSubview(logoSectionView)
        logoSectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoSectionView.topAnchor.constraint(equalTo: upperContainerView.topAnchor, constant: 5),
            
            logoSectionView.trailingAnchor.constraint(equalTo: upperContainerView.trailingAnchor, constant: -10),
            logoSectionView.bottomAnchor.constraint(equalTo: upperContainerView.bottomAnchor, constant: -5),
            logoSectionView.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}

extension YoutubeCollapsableView: MainLogosViewDelegate {
    func youtubeLogoImagesTapped(on logo: YoutubeLogos) {
        delegate?.logoTappedFromCollapsableView(on: logo)
    }
}
