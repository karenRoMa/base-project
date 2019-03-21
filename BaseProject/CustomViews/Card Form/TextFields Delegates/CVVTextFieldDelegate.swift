//
//  CVVTextFieldDelegate.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

// MARK: - CCV textFieldDelegate -

import UIKit

class CVVTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Singleton Properties -
    
    static let shared = CVVTextFieldDelegate()
    
    // MARK: - Stored Properties -
    
    let numbers: [Int] = Array<Int>(0...9)
    
    // MARK - UITextFieldDelegate -
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return true}
        
        if string.isEmpty {return true}
        if text.count > 3 {return false}
        guard let stringInt = Int(string) else {return false}
        if numbers.contains(stringInt) {return true}
        return false
    }
    
}
