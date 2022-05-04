//
//  Icons.swift
//  ivi
//
//  Created by Samuel Wong on 26/4/22.
//

import UIKit

enum Icons: Int, CaseIterable {
    case Rook = 0
    case Dragon
    case Cookie
    case Champagne
    case Camera
    case Bomb
    case ArrowLock
    case ArrowLockSolid
    case Eye
    
    var title: String {
        switch self {
        case .Rook : return "Rook"
        case .Dragon : return "Dragon"
        case .Cookie : return "Cookie"
        case .Champagne : return "Champagne"
        case .Camera : return "Camera"
        case .Bomb : return "Bomb"
        case .ArrowLock : return "Arrow Lock"
        case .ArrowLockSolid : return "Arrow Lock Solid"
        case .Eye : return "Eye"
        }
    }
    
    var name: String {
        switch self {
        case .Rook : return "Rook"
        case .Dragon : return "Dragon"
        case .Cookie : return "Cookie"
        case .Champagne : return "Champagne"
        case .Camera : return "Camera"
        case .Bomb : return "Bomb"
        case .ArrowLock : return "ArrowLock"
        case .ArrowLockSolid : return "ArrowLockSolid"
        case .Eye : return "Eye"
        }
    }
    
    var previewImage: UIImage! {
        var fileName: String!
        switch self {
        case .Rook : fileName = "rook@3x"
        case .Dragon : fileName = "dragon@3x"
        case .Cookie : fileName = "cookie@3x"
        case .Champagne : fileName = "champagne@3x"
        case .Camera : fileName = "camera@3x"
        case .Bomb : fileName = "bomb@3x"
        case .ArrowLock : fileName = "arrow-lock@3x"
        case .ArrowLockSolid : fileName = "arrow-lock-solid@3x"
        case .Eye : fileName = "eye@3x"
        }
        
        return UIImage(named: fileName)
    }
}
