//
//  PaymentRouter.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/11/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import CoreData

/// Type defined to describe the requests parameters
typealias Parameters = [String: Any]

/**
 Router where all the available requests are defined and all their properties nedeed to perform the request to the server
 ````
 case singleChargeByAmount(Parameters)
 case singleChargeByCard(Parameters)
 case departmentStoreCharge(Parameters)
 case generateClient(Parameters)
 case associatePaymentToClient(Parameters)
 case getClientInformation(String)
 
 ````
 */
enum PaymentRouter: CaseIterable {
    
    /**
     This is only used to show all the available requests.
     In any other project if is not useful the variable allCases should be removed and PaymentRouter should not be CaseIterable
     
     The parameters are only for testing porpuse
    */
    static var allCases: [PaymentRouter] {
        var tokenId = ""
        if ProjectSingleton.shared.cards.count > 0 {
            tokenId = ProjectSingleton.shared.cards[ProjectSingleton.shared.cardSelectedIndex].token ?? ""
        }

        return [
            .singleChargeByAmount(
                [
                    "description": "500 gems - Clash Royale",
                    "token_id": tokenId,
                    "amount": 550.55
                ]
            ),
            .singleChargeByCard(
                [
                 "description": "500 gems - Clash Royale",
                 "token_id": tokenId,
                 "line_items_id": [ "qEMP45YBOE", "mOl6PP0ICg"]
                ]
            ),
            .departmentStoreCharge(
                [
                    "way_to_pay": "OXXO",
                    "description": "500 gems - Clash Royale",
                    "line_items_id": [
                        "qEMP45YBOE",
                        "mOl6PP0ICg"
                    ]
                ]
            ),
            .generateClient(
                [
                    "name": "Roberto Martínez Medina",
                    "email": "roberto@arkstud.io",
                    "phone": "5522128504",
                    "token_id": tokenId
                ]
            ),
            .associatePaymentToClient(
                [
                    "customer_id": "cus_2kBJ6h86Bzb9b5uTx",
                    "payment_source_id": "src_2kBJ6h86Bzb9b5uU1",
                    "line_items_id": [
                        "1",
                        "2"
                    ],
                    "description": "Clash Royale Gems - 500"
                ]
            ),
            .getClientInformation("cus_2kBa9BffDvPkFutrY")
        ]
    }
    
    /// Base URL in String format for the API
    static var baseURLString: String {
        guard let infoPlist = Bundle.main.infoDictionary else {return ""}
        return infoPlist["PaymentsBaseURL"] as? String ?? ""
    }
    
    // MARK: - Single Charge -
    
    case singleChargeByAmount(Parameters)
    case singleChargeByCard(Parameters)
    case departmentStoreCharge(Parameters)
    
    // MARK: - Client -
    
    case generateClient(Parameters)
    case associatePaymentToClient(Parameters)
    case getClientInformation(String)
    
    // MARK: - Properties -
    
    var jsonDecoder: JSONDecoder {
        return JSONDecoder()
    }
    
    /**
     Description of the request in the given case
     */
    var requestDescription: String {
        switch self {
        case .singleChargeByAmount:
            return "Create a single charge with an amount"
        case .singleChargeByCard:
            return "Create a single charge with a card"
        case .departmentStoreCharge:
            return "Create a charge to pay in a department store"
        case .generateClient:
            return "Generate a client with a payment method to use later"
        case .associatePaymentToClient:
            return "Associate charge to an existent client"
        case .getClientInformation:
            return "Fetch the client information"
        }
    }

    /// The method for the give request (It can be POST, GET, PUT or DELETE)
    var method: RequestMethod {
        switch self {
        case .singleChargeByAmount,
            .singleChargeByCard,
             .departmentStoreCharge,
             .generateClient,
             .associatePaymentToClient:
            return .post
        case .getClientInformation:
            return .get
        }
    }
    
    /// The path for the given request (contains query parameters in case of exist given in each case)
    var path: String {
        switch self {
        case .singleChargeByAmount:
            return "/payments/charge_by_amount"
        case .singleChargeByCard:
            return "payments/single_charge"
        case .departmentStoreCharge:
            return "payments/charge_per_department_store"
        case .generateClient:
            return "payments/generate_client"
        case .associatePaymentToClient:
            return "payments/user_associated_payment"
        case .getClientInformation(let customerId):
            return "payments/client_information/\(customerId)"
        }
    }
    
    func responseType(with data: Data) -> Any? {
        switch self {
        case .singleChargeByAmount,
             .singleChargeByCard,
             .departmentStoreCharge,
             .associatePaymentToClient:
            return try? self.jsonDecoder.decode(CreateSingleChargeResponse.self, from: data)
        case .generateClient:
            return try? self.jsonDecoder.decode(GenerateClientResponse.self, from: data)
        case .getClientInformation:
            return try? self.jsonDecoder.decode(ClientInformationResponse.self, from: data)
        }
    }

    /*
        MARK: - URLRequest -
     
        Creates URLRequest with the given method and parameters to make the request.
    */
    
    private func asUrlRequest() -> URLRequest {
        let urlBase = URL(string: PaymentRouter.baseURLString)!
        var request = URLRequest(url: urlBase.appendingPathComponent(path))
        
        request.httpMethod = method.value

        switch self {
        case .singleChargeByAmount(let parameters),
             .singleChargeByCard(let parameters),
             .departmentStoreCharge(let parameters),
             .generateClient(let parameters),
             .associatePaymentToClient(let parameters):
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBody(parameters: parameters)
        default:
            break
        }
        return request
    }
    

    /// Parse the parameters to a valid format to make the request
    private func createBody(parameters: [String : Any]) -> Data? {
        let json: Data
        do {
            json = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error: cannot create JSON parameter")
            return nil
        }
        return json
    }
    
    func performRequest(completionBlock: @escaping (Any?) -> ()) {
        let task = URLSession.shared.dataTask(with: self.asUrlRequest()) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    HandlerError.shared.handle(withError: ErrorType(responseError: nil, serverError: error!), delegate: nil)
                    completionBlock(nil)
                }
                return
            }
            
            if let data = data,
                let response = self.responseType(with: data) {
                DispatchQueue.main.async {
                    completionBlock(response)
                }
                return
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                if json != nil {
                    HandlerError.shared.handle(withError: ErrorType(responseError: json!!))
                }
                
                completionBlock(nil)
            }
        }
        task.resume()
    }
    
}
