//
//  UIColor + Utilities.swift
//  ivi
//
//  Created by Samuel Wong on 14/4/22.
//

import UIKit

extension UIColor {
    class func colourWithHexStringAndAlpha(_ hex: String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    class func colourWithHexString(_ hex: String) -> UIColor {
        return UIColor.colourWithHexStringAndAlpha(hex, alpha: 1)
    }

}
