//
//  UIColorExtension.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/11/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

// MARK: - UIColor Extension -
/*
 This Extension help us declare all the colors we will need in the project
 Above are examples with the colors used in the Base Project
 
 - @nonobjc attribute indicates that this variable can't be migrated to Objective-C
 - class func indicates that it can be overriden if needed in any class

 */

extension UIColor {
    
    // MARK: - Main App Colors -

    @nonobjc class func pink(opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 246.0 / 255.0, green: 114.0 / 255.0, blue: 128.0 / 255.0, alpha: opacity)
    }
    
    @nonobjc class func cream(opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 248.0 / 255.0, green: 177.0 / 255.0, blue: 149.0 / 255.0, alpha: opacity)
    }
    
    @nonobjc class func palidPink(opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 192.0 / 255.0, green: 108.0 / 255.0, blue: 132.0 / 255.0, alpha: opacity)
    }
    
    @nonobjc class func palidPurple(opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 108.0 / 255.0, green: 91.0 / 255.0, blue: 123.0 / 255.0, alpha: opacity)
    }
    
    @nonobjc class func darkSkyBlue(opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 53.0 / 255.0, green: 92.0 / 255.0, blue: 125.0 / 255.0, alpha: opacity)
    }
    
    // MARK: - Auxiliar Colors -
    
    /*
    If there are especific colors for some buttons or labels they should be specified divided in sections usins the MARK label
     */
}

