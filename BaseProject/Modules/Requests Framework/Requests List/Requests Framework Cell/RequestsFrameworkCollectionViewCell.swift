//
//  RequestsFrameworkCollectionViewCell.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/11/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class RequestsFrameworkCollectionViewCell: UICollectionViewCell {

    // MARK: - Singleton Properties -
    
    static let nibName: String = "RequestsFrameworkCollectionViewCell"
    static let reuseIdentifier: String = "RequestsFrameworkCollectionViewCellIdentifier"
    static let rowHeight: CGFloat = 100.0
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var requestTitleLabel: UILabel!
    @IBOutlet weak var requestMethodLabel: UILabel!
    @IBOutlet weak var requestPathLabel: UILabel!
    
    // MARK: - Stored Properties -
    
    var requestCase: PaymentRouter!
    
    // MARK: - View Delegate Methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstConfiguration()
    }
    
    // MARK: - Cell configuration -
    // Here goes all the configuration for the cell and auxiliar methods
    
    // Configuration for the cell that only should be the done once
    private func firstConfiguration() {
        mainView.round(with: 5.0)
        requestTitleLabel.textColor = UIColor.palidPink()
        requestMethodLabel.textColor = UIColor.white
        requestMethodLabel.round()
        requestPathLabel.textColor = UIColor.palidPurple()
    }
    
    // Configuration of the cell after passing information about the content
    func configureCell() {
        requestTitleLabel.text = requestCase.requestDescription
        requestMethodLabel.text = requestCase.method.value
        requestMethodLabel.backgroundColor = requestCase.method.color
        requestPathLabel.text = requestCase.path
    }

}
