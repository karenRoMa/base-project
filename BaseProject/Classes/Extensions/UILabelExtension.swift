//
//  UILabelExtension.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/14/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// The text for the label will be replaced with the text set in UI.strings file for the given key
    open override func awakeFromNib() {
        super.awakeFromNib()
        text = text?.localized(bundle: .main, tableName: "UI")
    }
    
    func emptyLabel(withText text: String) -> UILabel {
        self.text = text
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 16.0)
        textColor = UIColor.black.withAlphaComponent(0.25)
        return self
    }
}
