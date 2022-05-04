//
//  Media+CoreDataProperties.swift
//  ivi
//
//  Created by Samuel Wong on 20/4/22.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var filename: String?
    @NSManaged public var blur: Bool
    @NSManaged public var isVideo: Bool
    @NSManaged public var thumbnailFilename: String?

}

extension Media : Identifiable {

}
