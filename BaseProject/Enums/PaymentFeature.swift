//
//  PaymentFeature.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

enum PaymentFeature: String, CaseIterable {
    case registerCard
    case cardsList
    case requests
    
    var text: String {
        return self.rawValue.camelToSnakeCase().localized(bundle: .main, tableName: "UI")
    }
    
    var controller: UIViewController {
        switch self {
        case .registerCard:
            return CardFormViewController()
        case .cardsList :
            return CardsListViewController()
        case .requests:
            return RequestsListViewController()
        }
    }
}
