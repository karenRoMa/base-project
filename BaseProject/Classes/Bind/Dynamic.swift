//
//  Dynamic.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

class Dynamic<T> {
    var value: T {
        didSet {
            for bondBox in bonds {
                bondBox.bond?.listener(value)
            }
        }
    }
    
    var bonds: [BondBox<T>] = []
    
    init(_ v: T) {
        value = v
    }
}
