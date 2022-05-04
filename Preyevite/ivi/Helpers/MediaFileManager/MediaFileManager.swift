//
//  MediaFileManager.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit
import AVKit

class MediaFileManager {
    static func saveImage(image: UIImage, compressionQuality: CGFloat = 1.0) -> (fileName: String?, error: Error?) {
        guard let data = image.jpegData(compressionQuality: compressionQuality) else { return (nil, NSError.standardErrorWithString(errorString: "Image could not be converted to data.")) }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return (nil, NSError.standardErrorWithString(errorString: "No document directory exists."))
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            let fileName = dateFormatter.string(from: Date()) + ".png"
            
            try data.write(to: directory.appendingPathComponent(fileName)!)
            return (fileName, nil)
        } catch {
            return (nil, error)
        }
    }

    static func loadImage(fileName: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(fileName).path)
        }
        return nil
    }

    static func saveVideo(url: URL) -> (fileName: String?, error: Error?) {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return (nil, NSError.standardErrorWithString(errorString: "No document directory exists."))
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            let fileName = dateFormatter.string(from: Date()) + ".mp4"
            
            let data = try Data(contentsOf: url)
            try data.write(to: directory.appendingPathComponent(fileName)!)
            return (fileName, nil)
        } catch {
            return (nil, error)
        }
    }
    
    static func videoURL(withPath fileName: String) -> URL? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(fileName)
        }
        return nil
    }
    
    static func deleteFile(withPath fileName: String) {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let path = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(fileName)

            try? FileManager.default.removeItem(atPath: path.path)
        }
    }
}
