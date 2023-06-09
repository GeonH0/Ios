//
//  CardListCell.swift
//  RecommendCreditCard
//
//  Created by 김건호 on 2023/04/24.
//

import UIKit

class CardListCell: UITableViewCell {

    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
