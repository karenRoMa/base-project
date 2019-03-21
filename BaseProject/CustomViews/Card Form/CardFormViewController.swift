//
//  CardFormViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/13/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class CardFormViewController: UIViewController {
    
    // MARK: - Singleton Properties -
    
    static let nibName: String = "CardFormViewController"
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var registerCardTitlteLabel: UILabel!
    @IBOutlet weak var cardNumberTitleLabel: UILabel!
    @IBOutlet weak var cardNumberTextField: BindingTextField!
    @IBOutlet weak var cardHolderTitleLabel: UILabel!
    @IBOutlet weak var cardHolderTextField: BindingTextField!
    @IBOutlet weak var expirationTitleLabel: UILabel!
    @IBOutlet weak var expirationTextField: BindingTextField!
    @IBOutlet weak var cvvTitleLabel: UILabel!
    @IBOutlet weak var cvvTextField: BindingTextField!
    @IBOutlet weak var registerCardButton: LoadingButton!
    
    // MARK: - Stored Properties -
    
    // Card Form View Model
    lazy var viewModel: CardFormViewModel = {
        return CardFormViewModel()
    }()
    
    var pickerView: UIPickerView = UIPickerView()
    var pickerMonthsAndYears: [[Int]] = [Array(1...12), Array(18...99)]
    var expirationMonthSelected: String = "01"
    var expirationYearSelected: String = "01"
    
    // MARK: - View Delegate Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        initViewModel()
    }
    
    // MARK: - View configuration -

    func configureView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Text Fields
        
        cardNumberTextField.delegate = CardTextFieldDelegate.shared
        cardNumberTextField.placeholder = " Introduce el número de tu tarjeta"
        cardHolderTextField.placeholder = " Introduce el nombre asociado a tu tarjeta"
        expirationTextField.inputView = pickerView
        expirationTextField.placeholder = " MM / YY"
        cvvTextField.delegate = CVVTextFieldDelegate.shared
        cvvTextField.addTarget(viewModel, action: #selector(CardFormViewModel.textFieldDidChange), for: .editingDidEnd)
        cvvTextField.placeholder = " CVV"
        registerCardButton.setDisableStyle()
    }
    
    // MARK: - View Model Initial Configuration -
    
    func initViewModel() {
        viewModel.delegate = self
        cardHolderTextField.bind {self.viewModel.card.holder.value = $0}
        cardNumberTextField.bind {self.viewModel.card.number.value = $0}
        cvvTextField.bind {self.viewModel.card.cvv.value = $0}
    }
    
    // MARK: - IBActions -
    
    @IBAction func registerCard(_ sender: LoadingButton) {
        sender.showLoading()
        viewModel.cardComplete()
    }
    
}

// MARK: - Picker View configuration -

extension CardFormViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerMonthsAndYears[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.pickerMonthsAndYears[component][row] < 10 {
            return "0\(self.pickerMonthsAndYears[component][row])"
        }
        return "\(self.pickerMonthsAndYears[component][row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if self.pickerMonthsAndYears[component][row] < 10 {
                self.expirationMonthSelected = "0\(self.pickerMonthsAndYears[component][row])"
            } else {
                self.expirationMonthSelected = "\(self.pickerMonthsAndYears[component][row])"
            }
        } else {
            if self.pickerMonthsAndYears[component][row] < 10 {
                self.expirationYearSelected = "0\(self.pickerMonthsAndYears[component][row])"
            } else {
                self.expirationYearSelected = "\(self.pickerMonthsAndYears[component][row])"
            }
        }
        self.expirationTextField.text = "\(self.expirationMonthSelected) / \(self.expirationYearSelected)"
        viewModel.card.expirationMonth.value = self.expirationMonthSelected
        viewModel.card.expirationYear.value = self.expirationYearSelected
        viewModel.textFieldDidChange()
    }
    
    func setFirstMonthInOptions() {
        if self.expirationYearSelected != "01" {
            return
        }
        let date = Date()
        let calendar = Calendar.current
        
        // Current year
        let thisYear = calendar.component(.year, from: date)
        let thisYearText = String(thisYear)
        let last2Digits = thisYearText.suffix(2)
        if let yearToSelect = Int(last2Digits),
            let yearInPickerIndex = pickerMonthsAndYears[1].index(of: yearToSelect) {
            self.pickerView.selectRow(yearInPickerIndex, inComponent: 1, animated: true)
            self.expirationYearSelected = String(last2Digits)
        }
        
        // Current month
        let thisMonth = calendar.component(.month, from: date)
        var thisMonthText = String(thisMonth)
        if thisMonth < 10 {
            thisMonthText = "0\(thisMonth)"
        }
        if let monthInPickerIndex = pickerMonthsAndYears[0].index(of: thisMonth) {
            self.pickerView.selectRow(monthInPickerIndex, inComponent: 0, animated: true)
            self.expirationMonthSelected = thisMonthText
        }
    }
}

// MARK: - Card Form View Model Delegate

extension CardFormViewController: CardFormViewModelDelegate {
    
    func changeRegisterButtonStatus(to status: Bool) {
        registerCardButton.isEnabled = status
        status ? registerCardButton.setEnableStyle() : registerCardButton.setDisableStyle()
    }
    
    func finishRegister() {
        registerCardButton.hideLoading()
        
        /// Code if the user stays in the view, delete in case of transition
        if viewModel.errorMessage == "" {
            cardNumberTextField.text = ""
            cardHolderTextField.text = ""
            expirationTextField.text = ""
            cvvTextField.text = ""
            registerCardButton.isEnabled = false
            registerCardButton.setDisableStyle()
        }
    }
}
