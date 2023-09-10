//
//  logoImageView.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/10.
//

import UIKit

class MainLogosView: UIView {
    
    let squareImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "squareLogo")
        return iv
    }()
    
    let bellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "bell")
        iv.tintColor = .black
//        iv.image = UIImage(named: "bellLogo")
        return iv
    }()
    
    let searchImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = .black
        return iv
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 14
        iv.clipsToBounds = true
        iv.image = UIImage(named: "profile1")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addsubViews()
        configureProfileImageView()
        configureSearchImageView()
        configureBellImageView()
        configureSquareImageView()
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
