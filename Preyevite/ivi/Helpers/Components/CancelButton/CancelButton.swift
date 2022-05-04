//
//  CancelButton.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit

@IBDesignable
class CancelButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularCorners()
        self.setTitleColor(Theme.Colours.White.uiColor, for: .normal)
        self.tintColor = Theme.Colours.White.uiColor
    }
}

extension CancelButton {
    func initialize() {
        self.setTitleColor(Theme.Colours.White.uiColor, for: .normal)
        self.tintColor = Theme.Colours.White.uiColor
        self.backgroundColor = Theme.Colours.Gray.uiColor.withAlphaComponent(0.6)
    }
}
