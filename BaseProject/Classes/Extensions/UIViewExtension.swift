//
//  UIViewExtension.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/12/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Returns view from nib from any uiview subclass
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /// Round specific corners
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        layer.masksToBounds = true
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func round(with radius: CGFloat? = nil) {
        if radius != nil {
            layer.cornerRadius = radius!
        } else {
            layer.cornerRadius = self.bounds.height/2
        }
        layer.masksToBounds = true
    }
    
    func applyHorizontalGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map{$0.cgColor}
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map{$0.cgColor}
        gradient.locations = locations
        layer.insertSublayer(gradient, at: 0)
    }
    
    func applyShadow(color: UIColor = UIColor.black, opacity: Float = 1.0, radius: CGFloat = 5.0, verticalOffset: CGFloat = 0, horizontalOffset: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: horizontalOffset, height: verticalOffset)
        layer.shadowRadius = 5
        layer.masksToBounds = false
    }
}
