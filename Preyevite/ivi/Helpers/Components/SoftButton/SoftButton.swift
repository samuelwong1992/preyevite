//
//  SoftButton.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit

@IBDesignable
class SoftButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
    
    
}

extension SoftButton {
    func initialize() {
        self.setTitleColor(Theme.Colours.Black.uiColor.withAlphaComponent(0.6), for: .normal)
        self.tintColor = Theme.Colours.Black.uiColor.withAlphaComponent(0.6)
    }
}
