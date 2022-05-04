//
//  MediaCollectionViewController.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit
import PhotosUI
import AVKit

class MediaCollectionViewController: UIViewController {

    static var viewController: MediaCollectionViewController? {
        return StoryboardConstants.Storyboards.MediaCollection.storyboard.instantiateInitialViewController() as? MediaCollectionViewController
    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension MediaCollectionViewController {
    func initialize() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.kReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        settingsButton.backgroundColor = Theme.Colours.Primary.uiColor
        settingsButton.tintColor = Theme.Colours.White.uiColor
        settingsButton.setCircularCorners()
        
        cancelButton.addTarget(self, action: #selector(cancelButton_didPress), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButton_didPress), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButton_didPress), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(NotificationConstants.Notifications.RefreshCollectionView.name), object: nil)
    }
    
    @objc func reloadData() {
        self.collectionView.reloadData()
    }
}

//MARK: Button Handlers
@objc extension MediaCollectionViewController {
    func cancelButton_didPress() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addButton_didPress() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func settingsButton_didPress() {
        if let vc = StoryboardConstants.Storyboards.Settings.storyboard.instantiateInitialViewController() {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: CollectionView Delegate and DataSource
extension MediaCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MediaHelpers.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.kReuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.photo = MediaHelpers.medias[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let shortEdge = collectionView.frame.size.width < collectionView.frame.size.height ? collectionView.frame.size.width : collectionView.frame.size.height
        return CGSize(width: shortEdge/3, height: shortEdge/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = MediaHelpers.medias[indexPath.row]
        if media.isVideo {
            guard let url = MediaFileManager.videoURL(withPath: media.filename!) else { return }
            let player = AVPlayer(url: url)
            let playerVC = AVPlayerViewController()
            playerVC.player = player
            player.play()
            present(playerVC, animated: true, completion: nil)
        } else {
            if let vc = MediaPageViewController.viewController {
                let index = MediaHelpers.medias.filter({ !$0.isVideo }).firstIndex(of: media)!
                vc.index = index
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let media = MediaHelpers.medias[indexPath.row]
        let config = UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { element in
            let blurElement = UIAction(title: media.blur ? "Unblur" : "Blur", image: nil, identifier: nil) { (action) in
                let error = media.setBlur(newBlur: !media.blur)
                if let error = error {
                    UIAlertController.showAlertWithError(viewController: self, error: error)
                } else {
                    self.collectionView.reloadData()
                }
            }
            let deleteElement = UIAction(title: "Delete", image: nil, identifier: nil) { (action) in
                let error = media.delete()
                if let error = error {
                    UIAlertController.showAlertWithError(viewController: self, error: error)
                } else {
                    self.collectionView.reloadData()
                }
            }

            let menu = UIMenu(title: "", children: [blurElement, deleteElement])
            
            return menu
        }
        
        return config
    }

}

//MARK: Camera Picker Delegate
extension MediaCollectionViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let photoTuple = MediaHelpers.createMedia(fromImage: image)
        
        picker.dismiss(animated: true) {
            self.collectionView.reloadData()
            if let error = photoTuple.error {
                UIAlertController.showAlertWithError(viewController: self, errorString: error.localizedDescription)
            }
        }
    }
}

//MARK: PH Picker Delegate
extension MediaCollectionViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { [self] (videoURL, error) in
                    if let url = videoURL {
                        let videoTuple = MediaHelpers.createMedia(fromVideo: url)
                        if let error = videoTuple.error {
                            UIAlertController.showAlertWithError(viewController: self, errorString: error.localizedDescription)
                        }
                        DispatchQueue.main.async {
                            self.reloadData()
                        }
                    }
                }
            } else if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
                    DispatchQueue.main.async {
                        if let image = object as? UIImage {
                            let photoTuple = MediaHelpers.createMedia(fromImage: image)
                            if let error = photoTuple.error {
                                UIAlertController.showAlertWithError(viewController: self, errorString: error.localizedDescription)
                            }
                            DispatchQueue.main.async {
                                self.reloadData()
                            }
                        }
                    }
                })
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
