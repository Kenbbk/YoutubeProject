//
//  LongCell.swift
//  YoutubeProject
//
//  Created by Woojun Lee on 2023/09/06.
//

import UIKit
import youtube_ios_player_helper

class LongCell: UICollectionViewCell, ImageLoad {
    
    static let identifier = "LongCell"
    
    var videoModel: VideoModel?
    
    lazy var videoView: YTPlayerView = {
        let view = YTPlayerView()
        
        view.isUserInteractionEnabled = false
        return view
    }()
    
    @objc func tapped() {
        print("SEESES")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.backgroundColor = .red
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        
        return iv
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
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    func cropImage1(image: UIImage, rect: CGRect) -> UIImage {
        let cgImage = image.cgImage! // better to write "guard" in realm app
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
    
    
    
    @objc func optionImageTapped() {
        print("optioin image tapped")
        
    }
    
    func play(model: VideoModel) {
        
        DataManager().getImage(urlString: model.thumbnails) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                
                let image = self.cropImage1(image: image, rect: CGRect(x: 0, y: 64, width: 640, height: 354))
                DispatchQueue.main.async {
                
                    self.imageView.image = image
                    self.titleLabel.text = model.title
                    self.infoLabel.attributedText = NSAttributedString(string: "\(model.channelTitle) ・ \(model.viewCount.formatViewCounts()) ・ \(model.publishedAt.getHowLongAgo())", attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 12)])
                }
                
            }
        }

        
        
        
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
        configureThumbnail()
        configureImageView()
        configureTitleLabel()
        configureInfoLabel()
        configureOptionImageView()
    }
    
    
    
    private func addSubViews() {
        [videoView, imageView, channelImageView, titleLabel, infoLabel, optionImageView].forEach { view in
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
    
    private func configureThumbnail() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: videoView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor)
        ])
    }
    private func configureImageView() {
        NSLayoutConstraint.activate([
            channelImageView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 11),
            channelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            channelImageView.widthAnchor.constraint(equalToConstant: 36),
            channelImageView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: -3),
            titleLabel.leadingAnchor.constraint(equalTo: channelImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureInfoLabel() {
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -9),
            infoLabel.leadingAnchor.constraint(equalTo: channelImageView.trailingAnchor, constant: 11),
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
