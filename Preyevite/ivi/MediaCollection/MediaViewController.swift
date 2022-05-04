//
//  MediaViewController.swift
//  ivi
//
//  Created by Samuel Wong on 20/4/22.
//

import UIKit

class MediaViewController: UIViewController {
    
    static var viewController: MediaViewController? {
        return StoryboardConstants.Storyboards.MediaCollection.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.MediaViewController.identifier) as? MediaViewController
    }
    
    @IBOutlet var blurButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    var media: Media!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension MediaViewController {
    func initialize() {
        self.view.backgroundColor = Theme.Colours.Black.uiColor
        media.image { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        
        setupBlurButton()
        blurButton.addTarget(self, action: #selector(blurButton_didPress), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    func setupBlurButton() {
        blurButton.addBorder(withColor: UIColor.white.cgColor)
        blurButton.roundCorners()
        blurButton.backgroundColor = media.blur ? .white : .clear
        
        NotificationCenter.default.post(name: NSNotification.Name(NotificationConstants.Notifications.RefreshCollectionView.name), object: nil)
    }
}

//MARK: Button Handlers
@objc extension MediaViewController {    
    func blurButton_didPress() {
        let error = media.setBlur(newBlur: !media.blur)
        if let error = error {
            UIAlertController.showAlertWithError(viewController: self, error: error)
        }
        setupBlurButton()
    }
}

//MARK: Screenshot Handler
@objc extension MediaViewController {
    func screenshotTaken() {
        HistoryHelpers.createHistory(title: "Screenshot", note: "A screenshot was taken!", severity: .Critical)
    }
}

extension MediaViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
