//
//  SavedCardsTableViewCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 23/09/22.
//

import UIKit

class SavedCardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_CardNumberRef: UILabel!
    @IBOutlet weak var lbl_ExpiryMonthRef: UILabel!
    @IBOutlet weak var lbl_ExpiryYearRef: UILabel!
    @IBOutlet weak var btn_DeleteRef: UIButton!
    @IBOutlet weak var view_BackgroundRef: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
