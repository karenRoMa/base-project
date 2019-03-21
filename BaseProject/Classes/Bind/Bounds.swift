//
//  Bounds.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

class Bond<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener
    
    init(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    func bind(dynamic: Dynamic<T>) {
        dynamic.bonds.append(BondBox(self))
    }
}

class BondBox<T> {
    weak var bond: Bond<T>?
    init(_ b: Bond<T>) { bond = b }
}
