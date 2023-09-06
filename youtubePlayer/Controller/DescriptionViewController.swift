//
//  DescriptionViewController.swift
//  youtubePlayer
//
//  Created by JeonSangHyeok on 2023/09/06.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthDayLabel: UILabel!
    
    
    @IBAction func rightButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    var videoDate: String = ""
    var videoTitle: String = ""
    var videoDescription: String = ""
    var videoViewCount: String = ""
    var videoLikeCount: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        leftButton.isUserInteractionEnabled = false
        
        titleLabel.text = videoTitle
        decriptionLabel.text = videoDescription
        
        decriptionLabel.textAlignment = .left
        
        titleLabel.layer.addBorder([.top, .bottom], color: .black, width: 0.5)
        
        decriptionLabel.sizeToFit()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: decriptionLabel.frame.size.height)
        
        viewCountLabel.text = Formatter.formatViewCount(videoViewCount)
        likeCountLabel.text = Formatter.formatLikeCount(videoLikeCount)
        
        print(Formatter.formatDate(videoDate)?.year)
        print(Formatter.formatDate(videoDate)?.mothDay)
        
        yearLabel.text = Formatter.formatDate(videoDate)?.year
        monthDayLabel.text = Formatter.formatDate(videoDate)?.mothDay
    }
}

// label border 추가를 위한 extension
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
