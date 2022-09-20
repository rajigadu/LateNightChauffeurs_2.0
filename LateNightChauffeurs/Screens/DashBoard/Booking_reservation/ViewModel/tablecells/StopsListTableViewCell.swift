//
//  StopsListTableViewCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import UIKit

class StopsListTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_StopNameRef:UILabel!
    @IBOutlet weak var view_StopRef: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
