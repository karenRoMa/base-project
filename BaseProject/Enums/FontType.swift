//
//  FontType.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/13/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

enum FontType: String {
    case black = "Black"
    case blackItalic = "BlackItalic"
    case bold = "Bold"
    case boldItalic = "BoldItalic"
    case light = "Light"
    case lightItalic = "LightItalic"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case regular = "Regular"
    case semiBold = "Semibold"
    case semiBoldItalic = "SemiboldItalic"
    case thin = "Thin"
    
    var fontName: String {
        return "Lato"
    }
    
    var fullString: String {
        return "\(fontName)-\(self.rawValue)"
    }
}
