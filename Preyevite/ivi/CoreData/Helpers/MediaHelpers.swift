//
//  MediaHelpers.swift
//  ivi
//
//  Created by Samuel Wong on 14/4/22.
//

import UIKit
import AVKit

//private var imageCache: [String: UIImage] = [:]
private var imageCache: NSCache = NSCache<NSString, UIImage>()

class MediaHelpers {
    static func createMedia(fromImage image: UIImage) -> (media: Media?, error: Error?) {
        let media = Media(context: CoreDataManager.context)
        
        let savedMedia = MediaFileManager.saveImage(image: image)
        guard savedMedia.error == nil else { return (nil, savedMedia.error) }
        guard let fileName = savedMedia.fileName else { return (nil, NSError.standardNoDataError())}
        
        let savedMediaThumbnail = MediaFileManager.saveImage(image: image, compressionQuality: 0.4)
        guard savedMediaThumbnail.error == nil else { return (nil, savedMediaThumbnail.error) }
        guard let thumbnailfileName = savedMediaThumbnail.fileName else { return (nil, NSError.standardNoDataError())}
        
        media.filename = fileName
        media.thumbnailFilename = thumbnailfileName
        media.blur = false
        media.isVideo = false
        
        do {
            try CoreDataManager.context.save()
            return (media, nil)
        } catch {
            return (nil, error)
        }
    }
    
    static func createMedia(fromVideo url: URL) -> (media: Media?, error: Error?) {
        let media = Media(context: CoreDataManager.context)
        
        do {
            let asset = AVURLAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true

            let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                         actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            let savedMediaThumbnail = MediaFileManager.saveImage(image: image, compressionQuality: 0.4)
            guard savedMediaThumbnail.error == nil else { print("fdsa"); return (nil, savedMediaThumbnail.error) }
            guard let thumbnailfileName = savedMediaThumbnail.fileName else { print("asdf"); return (nil, NSError.standardNoDataError())}
            
            let savedMedia = MediaFileManager.saveVideo(url: url)
            guard savedMedia.error == nil else { print("asdf2"); return (nil, savedMedia.error) }
            guard let fileName = savedMedia.fileName else { print("asdf1"); return (nil, NSError.standardNoDataError())}
            
            media.thumbnailFilename = thumbnailfileName
            media.filename = fileName
            media.blur = false
            media.isVideo = true
            
            try CoreDataManager.context.save()
            return (media, nil)
        } catch {
            return (nil, error)
        }
    }
    
    static var medias: [Media] {
        get {
            do {
                return try CoreDataManager.container.viewContext.fetch(Media.fetchRequest())
            } catch {
                print(error)
                return []
            }
        }
    }
}

extension Media {
    func image(completion: @escaping ((UIImage?) -> Void)) {
        guard let filename = self.filename as? NSString else { return completion(nil) }
        guard let thumbnail = self.thumbnailFilename as? NSString else { return completion(nil) }
        guard imageCache.object(forKey: filename) == nil else { return completion(imageCache.object(forKey: filename)) }
        
        let serialQueue = DispatchQueue(label: "image_fetcher")
        serialQueue.async {
            if self.isVideo {
                let image = MediaFileManager.loadImage(fileName: String(thumbnail))
                DispatchQueue.main.async {
                    if let image = image {
                        imageCache.setObject(image, forKey: filename)
                    }
                    return completion(image)
                }
            } else {
                let image = MediaFileManager.loadImage(fileName: String(filename))
                DispatchQueue.main.async {
                    if let image = image {
                        imageCache.setObject(image, forKey: filename)
                    }
                    return completion(image)
                }
            }
        }
    }
    
    func thumbnail(completion: @escaping ((UIImage?) -> Void)) {
        guard let thumbnail = self.thumbnailFilename as? NSString else { return completion(nil) }
        guard imageCache.object(forKey: thumbnail) == nil else { return completion(imageCache.object(forKey: thumbnail)) }
        
        
        let serialQueue = DispatchQueue(label: "image_fetcher")
        serialQueue.async {
            let image = MediaFileManager.loadImage(fileName: String(thumbnail))
            DispatchQueue.main.async {
                if let image = image {
                    imageCache.setObject(image, forKey: thumbnail)
                }
                return completion(image)
            }
        }
    }
    
    func setBlur(newBlur: Bool) -> Error? {
        self.blur = newBlur
        do {
            try CoreDataManager.context.save()
            return nil
        } catch {
            return error
        }
    }
    
    func delete() -> Error? {
        if let filename = self.filename {
            MediaFileManager.deleteFile(withPath: filename)
        }
        
        if let filename = self.thumbnailFilename {
            MediaFileManager.deleteFile(withPath: filename)
        }
        
        CoreDataManager.context.delete(self)
        do {
            try CoreDataManager.context.save()
            return nil
        } catch {
            return error
        }
    }
}
