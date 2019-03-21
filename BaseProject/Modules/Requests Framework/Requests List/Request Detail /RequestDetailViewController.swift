//
//  RequestDetailViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/12/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var responseTitleLabel: UILabel!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Stored Properties -
    
    var request: PaymentRouter!
    
    /// ViewModel
    lazy var viewModel : RequestDetailViewModel? = {
        return RequestDetailViewModel()
    }()
    
    // MARK: - View Delegate Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        initViewModel()
    }
    
    // MARK: - View configuration -
    
    func configureView() {
        // Here we can do all related to view style or view configuration
        mainView.round(with: 5.0)
        mainView.isHidden = true
        
        // Add tap gesture to dismiss view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDetail))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - View Model Initial Configuration -
    
    func initViewModel() {
        /// Assign delegate implemented in [this section](x-source-tag://RequestDetailViewModel)
        viewModel?.delegate = self
        viewModel?.performRequest(with: request)
    }
    
    @objc func dismissDetail() {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Request Detail View Model Delegate -
/// - Tag: RequestDetailViewModel
// ----------------------------------------------------------

extension RequestDetailViewController : RequestDetailViewModelDelegate {
    
    func reloadUI(with response: Any?) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.mainView.isHidden = false
            
            if let validResponse  = response {
                self.responseTextView.text = String(describing: validResponse)
                self.responseTitleLabel.text = "Response (Status = Success) "
                self.responseTitleLabel.textColor = UIColor.black
            } else {
                self.responseTextView.text = "There was an error with the request. Try again please 😅 ."
                self.responseTitleLabel.text = "Response (Status = Error) "
                self.responseTitleLabel.textColor = UIColor.red
            }
        }
    }

}
