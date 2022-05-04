//
//  CoreDataManager.swift
//  ivi
//
//  Created by Samuel Wong on 14/4/22.
//

import CoreData

private var _container: NSPersistentContainer!

struct CoreDataManager {
    static var container: NSPersistentContainer {
        get {
            if _container != nil {
                return _container
            } else {
                _container = generatePersistentContainer()
                return _container
            }
        }
    }
    
    static var context: NSManagedObjectContext {
        return CoreDataManager.container.viewContext
    }
    
    static func generatePersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "ivi")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }
}
