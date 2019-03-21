//
//  Card.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/14/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

struct Card {
    var holder: Dynamic<String>
    var number: Dynamic<String>
    var cvv: Dynamic<String>
    var expirationMonth: Dynamic<String>
    var expirationYear: Dynamic<String>
    var brand: CardBrand?
    var token: String? = ""
    var isSelected: Bool = false
    
}
