//
//  NotificationConstants.swift
//  ivi
//
//  Created by Samuel Wong on 20/4/22.
//

struct NotificationConstants {
    enum Notifications: String {
        case ReturnToLogin = "ReturnToLogin"
        case RefreshCollectionView = "RefreshCollectionView"
        
        var name: String {
            return self.rawValue
        }
    }
}
