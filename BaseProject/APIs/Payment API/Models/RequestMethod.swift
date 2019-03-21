//
//  RequestMethod.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/12/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import UIKit

/**
 This is a enum with the posible methods to create a request
 ````
 case post: is used to send data to the server, for example, customer information, file upload, etc.
 case get: is used to retrieve information from the given server using a given URI. Requests using GET should only retrieve data and should have no other effect on the data.
 case put: replaces all current representations of the target resource with the uploaded content
 case delete: removes all current representations of the target resource given by a URI.
 ````
 */

enum RequestMethod: String {
    case post
    case get
    case put
    case delete
    
    // String value uppercased
    var value: String {
        return self.rawValue.uppercased()
    }
    
    /// A color to represent the method
    var color: UIColor {
        switch self {
        case .post:
            return UIColor(red: 17.0 / 255.0, green: 47.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
        case .get:
            return UIColor(red: 71.0 / 255.0, green: 171.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
        case .put:
            return UIColor(red: 242.0 / 255.0, green: 177.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
        case .delete:
            return UIColor(red: 237.0 / 255.0, green: 85.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)
        }
    }
}
