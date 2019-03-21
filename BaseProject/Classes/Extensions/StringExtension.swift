//
//  StringExtension.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/14/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Methods that returns self modified
    
    /// Returns string set in the given strings file for the key that equals self
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "", comment: "")
    }
    
    /// Converts string in camelCase to snake_case
    func camelToSnakeCase() -> String {
        var snake_case_string: String = ""
        let strUpper = "[A-Z0-9]";
        let strTest = NSPredicate(format:"SELF MATCHES %@", strUpper );
        
        for letter in self {
            if strTest.evaluate(with: String(letter)) {
                snake_case_string.append("_")
                snake_case_string.append(String(letter).lowercased())
            } else {
                snake_case_string.append(letter)
            }
        }
        return snake_case_string
    }
    
}
