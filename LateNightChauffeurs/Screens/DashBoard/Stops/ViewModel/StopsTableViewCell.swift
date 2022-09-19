//
//  StopsTableViewCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import UIKit

class StopsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_StoplocationRef: UILabel!
    @IBOutlet weak var btn_DeleteRef: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
