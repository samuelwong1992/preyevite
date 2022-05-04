//
//  MediaPageViewController.swift
//  ivi
//
//  Created by Samuel Wong on 20/4/22.
//

import UIKit

class MediaPageViewController: UIPageViewController {

    static var viewController: MediaPageViewController? {
        return StoryboardConstants.Storyboards.MediaCollection.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.MediaPageViewController.identifier) as? MediaPageViewController
    }
    
    var index = 0
    var photos: [Media] = MediaHelpers.medias.filter({ !$0.isVideo })
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension MediaPageViewController {
    func initialize() {
        self.delegate = self
        self.dataSource = self
        
        if let vc = MediaViewController.viewController {
            vc.media = photos[index]
            vc.index = index
            self.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
               
        let closeButton = CancelButton(type: .close)
        self.view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        closeButton.addTarget(self, action: #selector(closeButton_didPress), for: .touchUpInside)
    }
}

//MARK: Button Handlers
@objc extension MediaPageViewController {
    func closeButton_didPress() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Page Delegate and Data Source
extension MediaPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? MediaViewController {
            guard vc.index > 0 else { return nil }
            if let newVC = MediaViewController.viewController {
                newVC.index = vc.index - 1
                newVC.media = photos[vc.index - 1]
                return newVC
            }
        }
        
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? MediaViewController {
            guard vc.index < photos.count - 1 else { return nil }
            if let newVC = MediaViewController.viewController {
                newVC.index = vc.index + 1
                newVC.media = photos[vc.index + 1]
                return newVC
            }
        }
        
        return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
}
