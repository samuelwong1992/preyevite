//
//  PrimaryButton.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularCorners()
    }
}

extension PrimaryButton {
    func initialize() {
        self.layer.cornerRadius = self.frame.height/2
        self.setTitleColor(Theme.Colours.White.uiColor, for: .normal)
        self.tintColor = Theme.Colours.White.uiColor
        self.backgroundColor = Theme.Colours.Primary.uiColor
    }
}
