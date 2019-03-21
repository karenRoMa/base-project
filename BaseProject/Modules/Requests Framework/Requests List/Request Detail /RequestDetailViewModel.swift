//
//  RequestDetailViewModel.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/12/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

// MARK: - Protocol RequestDetailViewModel Declaration -
//-------------------------------------------------------------

protocol RequestDetailViewModelDelegate : class {
    func reloadUI(with response: Any?)
    func dismissDetail()
}

// MARK: - Request Detail View Model Implementation -
//-------------------------------------------------------------

class RequestDetailViewModel: NSObject {
    
    // MARK: - Stored Properties -
    
    /// - Tag: RequestDetailViewModel
    weak var delegate : RequestDetailViewModelDelegate?
    
     var dismissAlertBeforeAction: Bool = true
    
    func performRequest(with request: PaymentRouter) {
        if ProjectSingleton.shared.cards.count == 0 {
            switch request {
            case .singleChargeByAmount,
                 .singleChargeByCard,
                 .generateClient:
                HandlerError.shared.showAlert(with: "Debes registrar una tarjeta primero 🥺", delegate: self)
                return
            default:
                break
            }
        }
        
        request.performRequest { (response) in
            self.delegate?.reloadUI(with: response)
        }
    }
}

// MARK: - Alert Delegate -

extension RequestDetailViewModel: AlertDelegate {
    
    func action() {
        self.delegate?.dismissDetail()
    }
}
