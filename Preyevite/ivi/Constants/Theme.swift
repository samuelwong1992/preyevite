//
//  Theme.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit

struct Theme {
    enum Colours {
        case Primary
        
        case White
        case Black
        case Gray
        
        var uiColor: UIColor {
            switch self {
            case .Primary : return UIColor.colourWithHexString("#006400")
                
            case .White : return .white
            case .Black : return .black
            case .Gray : return .gray
            }
        }
    }
}
