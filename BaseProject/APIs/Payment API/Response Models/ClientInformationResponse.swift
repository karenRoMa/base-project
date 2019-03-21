//
//  ClientInformationResponse.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/20/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

struct ClientInformationResponse: Codable {
    let id: String
    let name: String
    let email: String
    let phone: String
    let payment_sources: [PaymentSource]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case payment_sources
    }
}

// Payment Source

struct PaymentSource: Codable {
    let id: String
    let last4: String
    let brand: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case last4
        case brand
        case name
    }
}
