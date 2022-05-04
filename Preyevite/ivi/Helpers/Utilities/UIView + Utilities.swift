//
//  UIView + Utilities.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

extension UIView {
    func addBorder(withColor color: CGColor = UIColor.black.cgColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color
    }
    
    func roundCorners(radius: CGFloat = 4.0) {
        self.layer.cornerRadius = radius
    }
    
    func setCircularCorners() {
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    func addSubViewWithSameSize(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subview.widthAnchor.constraint(equalTo: self.widthAnchor),
            subview.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
    }
    
    func addSubViewToTopLeft(subview: UIView, withSize size: CGSize) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            subview.widthAnchor.constraint(equalToConstant: size.width),
            subview.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
    
    func addSubViewToMiddleLeft(subview: UIView, withSize size: CGSize) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            subview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subview.widthAnchor.constraint(equalToConstant: size.width),
            subview.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
}
