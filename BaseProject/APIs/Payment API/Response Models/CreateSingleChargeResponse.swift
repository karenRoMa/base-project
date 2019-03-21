//
//  CreateSingleChargeResponse.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/20/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

struct CreateSingleChargeResponse: Codable {
    let payment_id: String
    let reference: String?
    let amount: Double
    
    enum CodingKeys: String, CodingKey {
        case payment_id
        case reference
        case amount
    }
}
