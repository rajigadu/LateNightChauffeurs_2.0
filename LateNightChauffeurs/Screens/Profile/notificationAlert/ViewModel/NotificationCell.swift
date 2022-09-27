//
//  NotificationCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var datalblref: UILabel!
    @IBOutlet weak var messagelblref: UILabel!
    @IBOutlet weak var tiltelbl_ref: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
