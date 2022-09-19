//
//  BookingsecondHeaderCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import UIKit

class BookingsecondHeaderCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var SeletcardBtnref: UIButton!
    @IBOutlet weak var cardNumberLblref: UILabel!
    @IBOutlet weak var CardTypeCardNameref: UILabel!
    @IBOutlet weak var CvvNumberLblref: UILabel!
    @IBOutlet weak var btnShowHide:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
