//
//  ProjectSingleton.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/12/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

/// - Tag: SingletonClass
/**
 This class contains important data that can be used in the entire app
 */
class ProjectSingleton {
    
    /// Tag: SingletonInstance
    static let shared = ProjectSingleton()
    
    // MARK - Payment Framework -
    
    var cardSelectedIndex : Int = 0
    var cards: [Card] = []
    
    /// Init Singleton
    private init(){}
    
}
