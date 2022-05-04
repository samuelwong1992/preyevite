//
//  CGPoint + Utilities.swift
//  ivi
//
//  Created by Samuel Wong on 14/4/22.
//

import UIKit

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx, y: self.y + dy)
    }
}
