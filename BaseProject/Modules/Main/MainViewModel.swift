//
//  MainViewModel.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

// MARK: - Protocol ViewModel Declaration -
//-------------------------------------------------------------

protocol ViewModelDelegate : class {
    func delegateMethodExample()
    func reloadUI()
}

// MARK: - View Model Implementation -
//-------------------------------------------------------------

class ViewModel: NSObject {

    /// - Tag: ViewModel
    weak var delegate : ViewModelDelegate?
    
    var frameworks: [Framework] = []
    /*
     This is a example of a method in the ViewModel
    */
    func viewModelMethodExample() {
        print("We can do all logic-related to the controller here")
        // If nedeed use the delegate to communicate with the view
        delegate?.delegateMethodExample()
    }
    
    /*
     This method simulates a request to fetch the frameworks
    */
    func fetchFramework() {
        frameworks.append(Framework(title: "Payments", type: .requests))
    }
    
}

