//
//  LongCell.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import UIKit
import youtube_ios_player_helper

class LongCell: UICollectionViewCell {
    
    static let identifier = "LongCell"
    
    var videoModel: VideoModel?
    
    let videoView: YTPlayerView = {
        let view = YTPlayerView()
        return view
    }()
    
    let channelImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "house")
        iv.layer.cornerRadius = 18
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var optionImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "option2")
        iv.backgroundColor = .white
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(optionImageTapped)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configureUI()
        setTitle()
        setImage()
        
    }
    
    @objc func optionImageTapped() {
        print("optioin image tapped")
        print(self.frame)
    }
    
    func play(model: VideoModel) {
        
        videoView.load(withVideoId: model.id)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        titleLabel.text = "조회수 784만회 나온 코코넛애플 직접 가서 먹어봄 (한국에 없음)"
        infoLabel.attributedText = NSAttributedString(string: "코코보라 ・ 447k views ・ 12 dyas ago", attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 13)])
    }
    
    private func setImage() {
        let url = URL(string: "https://yt3.ggpht.com/ytc/AOPolaQ1_4Ebm2nVlFiEJWF3tjhbMfjMulFqwtFwxqxd=s88-c-k-c0x00ffffff-no-rj")
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.channelImageView.image = image
                }
            }
        }
        
    }
    
    private func configureUI() {
        
        addSubViews()
        configureView()
        configureImageView()
        configureTitleLabel()
        configureInfoLabel()
        configureOptionImageView()
    }
    
    
    
    private func addSubViews() {
        [videoView, channelImageView, titleLabel, infoLabel, optionImageView].forEach { view in
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureView() {
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    private func configureImageView() {
        NSLayoutConstraint.activate([
            channelImageView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 10),
            channelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            channelImageView.widthAnchor.constraint(equalToConstant: 36),
            channelImageView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: channelImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureInfoLabel() {
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            infoLabel.leadingAnchor.constraint(equalTo: channelImageView.trailingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            infoLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureOptionImageView() {
        NSLayoutConstraint.activate([
            optionImageView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 13),
            optionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            optionImageView.widthAnchor.constraint(equalToConstant: 14),
            optionImageView.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
    
    
}
