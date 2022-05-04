//
//  ImageCollectionViewCell.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static var kReuseIdentifier = StoryboardConstants.Nibs.ImageCollectionViewCell.identifier
    
    var photo: Media! {
        didSet {
            photo.thumbnail { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
            isVideoImageView.isHidden = !photo.isVideo
            blurredEffectView.isHidden = !photo.blur
        }
    }
    
    var imageView: UIImageView!
    var isVideoImageView: UIImageView!
    var blurredEffectView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
}

//MARK: Initialization
extension ImageCollectionViewCell {
    func initialize() {
        imageView = UIImageView(frame: self.frame)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        backgroundColor = .red
        self.addSubViewWithSameSize(subview: imageView)
        
        isVideoImageView = UIImageView(frame: self.frame)
        isVideoImageView.image = UIImage.init(systemName: "play.fill")
        isVideoImageView.tintColor = Theme.Colours.Black.uiColor.withAlphaComponent(0.6)
        self.addSubViewToTopLeft(subview: isVideoImageView, withSize: CGSize(width: 32, height: 40))
        
        let blurEffect = UIBlurEffect(style: .light)
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        addSubViewWithSameSize(subview: blurredEffectView)
    }
}
