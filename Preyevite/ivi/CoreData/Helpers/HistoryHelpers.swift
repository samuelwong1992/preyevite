//
//  HistoryHelpers.swift
//  ivi
//
//  Created by Samuel Wong on 24/4/22.
//

import Darwin
import UIKit

class HistoryHelpers {
    enum Severity: Int16 {
        case None = 0
        case Warning
        case Critical
        
        var title: String {
            switch self {
            case .None : return "None"
            case .Warning : return "Warning"
            case .Critical : return "Critical"
            }
        }
        
        var colour: UIColor {
            switch self {
            case .None : return UIColor.black
            case .Warning : return UIColor.orange
            case .Critical : return UIColor.red
            }
        }
    }
    
    static var historys: [History] {
        get {
            do {
                return try CoreDataManager.container.viewContext.fetch(History.fetchRequest())
            } catch {
                print(error)
                return []
            }
        }
    }
    
    static func createHistory(title: String, note: String, severity: Severity) {
        let history = History(context: CoreDataManager.context)
        
        history.title = title
        history.note = note
        history.severity = severity.rawValue
        history.date = Date()
        
        do {
            try CoreDataManager.context.save()
            return
        } catch {
            return
        }

    }
}

extension History {
    func getSeverity() -> HistoryHelpers.Severity? {
        return HistoryHelpers.Severity(rawValue: self.severity)
    }
}
