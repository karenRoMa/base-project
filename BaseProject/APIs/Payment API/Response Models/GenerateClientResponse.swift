//
//  GenerateClientResponse.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/20/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

struct GenerateClientResponse: Codable {
    let customer_id: String
    let payment_source_id: String?
    
    enum CodingKeys: String, CodingKey {
        case customer_id
        case payment_source_id
    }
}
