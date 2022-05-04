//
//  History+CoreDataProperties.swift
//  ivi
//
//  Created by Samuel Wong on 24/4/22.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var severity: Int16
    @NSManaged public var title: String?

}

extension History : Identifiable {

}
