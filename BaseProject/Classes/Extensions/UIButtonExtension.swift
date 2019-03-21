//
//  UIButtonExtension.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/14/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// The title for the button will be replaced with the text set in UI.strings file for the given key
    open override func awakeFromNib() {
        super.awakeFromNib()
        let localizedTitle = title(for: .normal)?.localized(bundle: .main, tableName: "UI")
        setTitle(localizedTitle, for: .normal)
    }
    
    /// Style configuration for an enabled button
    func setEnableStyle() {
        round(with: 5.0)
        backgroundColor = UIColor.palidPink()
        setTitleColor(UIColor.white, for: .normal)
    }
    
    /// Style configuration for a disabled button 
    func setDisableStyle() {
        round(with: 5.0)
        backgroundColor = UIColor.lightGray
        setTitleColor(UIColor.darkGray, for: .disabled)
    }
}
