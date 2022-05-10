//
//  SoftButtonReversed.swift
//  ivi
//
//  Created by Samuel Wong on 10/5/2022.
//

import UIKit

@IBDesignable
class SoftButtonReversed: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
    
    
}

extension SoftButtonReversed {
    func initialize() {
        self.setTitleColor(Theme.Colours.White.uiColor.withAlphaComponent(0.6), for: .normal)
        self.tintColor = Theme.Colours.White.uiColor.withAlphaComponent(0.6)
    }
}
