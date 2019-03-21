//
//  MainTableViewCell.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Singleton Properties -
    
    static let nibName: String = "MainTableViewCell"
    static let reuseIdentifier: String = "MainTableViewCellIdentifier"
    static let rowHeight: CGFloat = 60.0
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Stored Properties -
    
    var framework: Framework!
    
    // MARK: - View Delegate Methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstConfiguration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Cell configuration -
    // Here goes all the configuration for the cell and auxiliar methods
    
    // Configuration for the cell that only should be the done once
    private func firstConfiguration() {
        selectionStyle = .none
    }
    
    // Configuration of the cell after passing information about the content
    func configureCell() {
        titleLabel.text = framework.title
    }
}
