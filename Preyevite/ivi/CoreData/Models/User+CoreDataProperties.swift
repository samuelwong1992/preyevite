//
//  User+CoreDataProperties.swift
//  ivi
//
//  Created by Samuel Wong on 20/4/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var pin: String?

}

extension User : Identifiable {

}
