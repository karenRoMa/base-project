//
//  BindingTextField.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

public var handle: UInt8 = 0

class BindingTextField: UITextField {
    
    // MARK: - Stored Properties -
    
    var textChanged: (String) -> Void = {_ in}
    
    var dynamic: Dynamic<String>?
    
    var bindText: Bond<String> {
        if let b = objc_getAssociatedObject(self, &handle) {
            return b as! Bond<String>
        } else {
            let b = Bond<String> { [unowned self] v in self.text = v }
            objc_setAssociatedObject(self, &handle, b, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return b
        }
    }

    // MARK: - Class Methods -
    
    func bind(callback : @escaping (String) -> Void) {
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func bidirectionalBind(dynamic: Dynamic<String>) {
        self.text = dynamic.value
        self.bindText.bind(dynamic: dynamic)
        bind {dynamic.value = $0}
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textChanged(textField.text!)
    }
    
}
