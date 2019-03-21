//
//  CardTextFieldDelegate.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

// MARK: - Card text field delegate -

import UIKit

class CardTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Singleton Properties -
    
    static let shared = CardTextFieldDelegate()
    
    // MARK: - Stored Properties -
    
    var actualSize: Int = 0
    
    // MARK - UITextFieldDelegate -
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return true}
        
        if string.isEmpty {return true}
        if text.count > 18 {return false}
        if (text.count - (1 * Int(text.count / 5) )) % 4 == 0 && text.count != 0 {
            textField.text? = textField.text! + " "
            return true
        }
        return true
    }
    
}
