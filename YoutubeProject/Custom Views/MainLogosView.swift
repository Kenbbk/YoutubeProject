//
//  logoImageView.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/10.
//

import UIKit

enum YoutubeLogos {
    case bell, search, square, profile, main
}

protocol MainLogosViewDelegate: AnyObject {
    func youtubeLogoImagesTapped(on logo: YoutubeLogos)
}

class MainLogosView: UIView {
    
    weak var delegate: MainLogosViewDelegate?
    
    lazy var squareImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "squareLogo")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(squareImageTapped)))
        return iv
    }()
    
    lazy var bellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "bell")
        iv.tintColor = .black
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bellImageTapped)))
        return iv
    }()
    
    lazy var searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = .black
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchImageTapped)))
        return iv
    }()
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 14
        iv.clipsToBounds = true
        iv.image = UIImage(named: "profile1")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped)))
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func squareImageTapped() {
        delegate?.youtubeLogoImagesTapped(on: .square)
    }
    
    @objc func bellImageTapped() {
        delegate?.youtubeLogoImagesTapped(on: .bell)
    }
    @objc func searchImageTapped() {
        delegate?.youtubeLogoImagesTapped(on: .search)
    }
    @objc func profileImageTapped() {
        delegate?.youtubeLogoImagesTapped(on: .profile)
    }
   
    
    private func configureUI() {
        self.isUserInteractionEnabled = true
        addsubViews()
        configureProfileImageView()
        configureSearchImageView()
        configureBellImageView()
        configureSquareImageView()
    }
    
    private func addGestures() {
        [squareImageView, bellImageView, profileImageView, searchImageView].forEach { view in
            
            
        }
    }
    
    private func addsubViews() {
        [squareImageView, bellImageView, profileImageView, searchImageView].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureProfileImageView() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            profileImageView.widthAnchor.constraint(equalToConstant: 29),
            profileImageView.heightAnchor.constraint(equalToConstant: 29)
        ])
    }
    
    private func configureSearchImageView() {
        NSLayoutConstraint.activate([
            searchImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchImageView.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -16),
            searchImageView.widthAnchor.constraint(equalToConstant: 23),
            searchImageView.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func configureBellImageView() {
        NSLayoutConstraint.activate([
            bellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bellImageView.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -16),
            bellImageView.widthAnchor.constraint(equalToConstant: 22),
            bellImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func configureSquareImageView() {
        NSLayoutConstraint.activate([
            squareImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            squareImageView.trailingAnchor.constraint(equalTo: bellImageView.leadingAnchor, constant: -16),
            squareImageView.widthAnchor.constraint(equalToConstant: 29),
            squareImageView.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
}
