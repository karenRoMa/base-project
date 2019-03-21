//
//  CardFormViewModel.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/14/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

// MARK: - CardFormViewModelDelegate

protocol CardFormViewModelDelegate : class {
    func showCustomAlert(withText text: String, okText: String, hideCancel: Bool, delegate: AlertDelegate?)
    func changeRegisterButtonStatus(to status: Bool)
    func finishRegister()
}

class CardFormViewModel: NSObject {

    // MARK: - Stored Properties -
    
    /// CardFormViewModelDelegate
    weak var delegate: CardFormViewModelDelegate?
    
    var errorMessage: String = "" {
        didSet {
            self.delegate?.showCustomAlert(withText: errorMessage, okText: "ACEPTAR", hideCancel: true, delegate: nil)
            self.delegate?.finishRegister()
        }
    }
    
    var card: Card = Card(holder: Dynamic(""), number: Dynamic(""), cvv: Dynamic(""), expirationMonth: Dynamic(""), expirationYear: Dynamic(""), brand: nil, token: "", isSelected: false)
    
    func cardComplete() {
        guard card.holder.value.trimmingCharacters(in: .whitespaces) != "" else {
            errorMessage = "El nombre del titular no puede estar vacío"
            return
        }
        
        guard card.number.value.trimmingCharacters(in: .whitespaces) != "" else {
            errorMessage = "El nombre del titular no puede estar vacío"
            return
        }
        
        guard card.expirationMonth.value.trimmingCharacters(in: .whitespaces) != "" else {
            errorMessage = "La expiración de la tarjeta no puede estar vacía"
            return
        }
        
        guard card.expirationYear.value.trimmingCharacters(in: .whitespaces) != "" else {
            errorMessage = "La expiración de la tarjeta debe contener el año"
            return
        }
        
        guard  card.cvv.value.trimmingCharacters(in: .whitespaces) != "" else {
            errorMessage = "El cvv de la tarjeta no puede estar vacía"
            return
        }
        addNewCreditCard()
    }
    
    func addNewCreditCard() {
        ConektaClient.shared.generateToken(cardObject: card, delegate: delegate as! UIViewController) { (token) in
            if let tokenCreated = token {
                let cardNumberText = "* * * * \(self.card.number.value.suffix(3))"
                self.card.number.value = cardNumberText
                self.card.cvv.value = ""
                self.card.expirationMonth.value = ""
                self.card.expirationYear.value = ""
                self.card.token = tokenCreated
                if ProjectSingleton.shared.cards.count == 0 {
                    self.card.isSelected = true
                }
                ProjectSingleton.shared.cards.append(self.card)
                self.delegate?.showCustomAlert(withText: "Tarjeta registrada correctamente", okText: "ACEPTAR", hideCancel: true, delegate: nil)
            }
            self.delegate?.finishRegister()
        }
    }
    
    // MARK: Text field delegate
    
    @objc func textFieldDidChange() {
        guard card.holder.value.trimmingCharacters(in: .whitespaces) != "",
            card.number.value.trimmingCharacters(in: .whitespaces) != "",
            card.expirationMonth.value.trimmingCharacters(in: .whitespaces) != "",
            card.expirationYear.value.trimmingCharacters(in: .whitespaces) != "",
            card.cvv.value.trimmingCharacters(in: .whitespaces) != "" else {
            self.delegate?.changeRegisterButtonStatus(to: false)
            return
        }
        
        self.delegate?.changeRegisterButtonStatus(to: true)
    }
}
