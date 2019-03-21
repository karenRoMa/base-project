//
//  PaymentFeatureCollectionViewCell.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class PaymentFeatureCollectionViewCell: UICollectionViewCell {

    // MARK: - Singleton Properties -
    
    static let nibName: String = "PaymentFeatureCollectionViewCell"
    static let reuseIdentifier: String = "PaymentFeatureCollectionViewCellIdentifier"
    static let rowHeight: CGFloat = 50.0
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var featureTitleLabel: UILabel!
    @IBOutlet weak var selectedIndicator: UIView!
    
    // MARK: - Stored Properties -
    
    override var isSelected: Bool {
        didSet {
            self.selectedIndicator.isHidden = !isSelected
        }
    }
    
    var feature: PaymentFeature!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstConfiguration()
    }
    
    // MARK: - Cell configuration -
    // Here goes all the configuration for the cell and auxiliar methods
    
    // Configuration for the cell that only should be the done once
    private func firstConfiguration() {
        featureTitleLabel.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        selectedIndicator.round()
        selectedIndicator.backgroundColor = UIColor.palidPurple()
    }
    
    // Configuration of the cell after passing information about the content
    func configureCell() {
        featureTitleLabel.text = feature.text
    }

}
