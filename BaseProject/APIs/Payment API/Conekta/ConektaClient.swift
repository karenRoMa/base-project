//
//  ConektaClient.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/11/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

/**
 This class generate the coneckta token
 Its important look that there are two types of keys:
    - Production
    - Development
 **/
class ConektaClient {
    
    // MARK: - Singleton Properties -
    static let shared: ConektaClient = ConektaClient()
    
    private init(){}
    
    // MARK: - Stored Properties -
    
    var conektaInstance: Conekta {
        let conekta = Conekta()
        conekta.publicKey = self.publicKey
        conekta.collectDevice()
        return conekta
    }
    
    var publicKey: String {
        guard let infoPlist = Bundle.main.infoDictionary else {return ""}
        return infoPlist["ConektaAPIKey"] as? String ?? ""
    }
    
    /**
     This function generates a token for a given card
     - Parameters:
        - cardNumber: 16 Digits of the card
        - name: Name of the card's holder
        - cvv: 3 or 4 digits of the cvv
        - expMonth: Month of the card expiration in format MM
        - expYear: Year of the card expiration in format YYYY
     */
    
    func generateToken(cardObject: Card, delegate: UIViewController, completion: @escaping (String?) -> Void) {
        conektaInstance.delegate = delegate
        let card = conektaInstance.card()
        card?.setNumber(cardObject.number.value, name: cardObject.holder.value, cvc: cardObject.cvv.value, expMonth: cardObject.expirationMonth.value, expYear: cardObject.expirationYear.value)
        let token = conektaInstance.token()
        token?.card = card
        token?.create(success: { (data) in
            if let dataDictionary = data as? [String : Any], let tokenValue = dataDictionary["id"] as? String {
                DispatchQueue.main.async {
                    completion(tokenValue)
                }
            }
            else {
                DispatchQueue.main.async {
                    HandlerError.shared.handle(withError: ErrorType(responseError: data as? [String : Any] ?? [:], serverError: nil))
                    completion(nil)
                }
            }
        }, andError: { (error) in
            DispatchQueue.main.async {
                HandlerError.shared.handle(withError: ErrorType(responseError: nil, serverError: error))
                completion(nil)
            }
        })
    }
    
}
