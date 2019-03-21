//
//  CardTableViewCell.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    // MARK - Singleton Properties -
    
    static let nibName: String = "CardTableViewCell"
    static let reuseIdentifier: String = "CardTableViewCellIdentifier"
    static let rowHeight: CGFloat = 50.0
    
    // MARK - IBOutlets -
    
    @IBOutlet weak var cardTypeImage: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var activeCardIndicator: UIImageView!
    
    // MARK: - Stored Properties -
    
    var card: Card!

    // MARK: - View Delegate Methods -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstConfiguration()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updateCard(cardSelected: selected)
        self.activeCardIndicator.isHidden = !selected
    }
    
    // MARK: - Cell configuration -
    // Here goes all the configuration for the cell and auxiliar methods
    
    // Configuration for the cell that only should be the done once
    private func firstConfiguration() {
        selectionStyle = .none
        activeCardIndicator.isHidden = true
    }
    
    // Configuration of the cell after passing information about the content
    func configureCell() {
        self.activeCardIndicator.isHidden = !card.isSelected
        self.cardTypeImage.image = UIImage(named: card.brand?.rawValue ?? "")
        self.cardNumberLabel.text = card.number.value
    }
    
    // AUX METHODS
    
    func updateCard(cardSelected: Bool) {
        guard cardSelected else {return}
        if let cardIndex = ProjectSingleton.shared.cards.firstIndex(where: { $0.number.value == self.card.number.value }) {
            ProjectSingleton.shared.cards[cardIndex].isSelected = true
            ProjectSingleton.shared.cardSelectedIndex = cardIndex
            self.card = ProjectSingleton.shared.cards[cardIndex]
        }
        
    }
    
}

