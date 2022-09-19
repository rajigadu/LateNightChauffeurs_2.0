//
//  AddressListTableViewCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {
    @IBOutlet weak var btn_DeleteActionRef: UIButton!
    @IBOutlet weak var btn_EditActionRef: UIButton!
    @IBOutlet weak var lbl_AddressRef: UILabel!
    @IBOutlet weak var lbl_AddressTyperEf: UILabel!
    @IBOutlet weak var lbl_CityRef: UILabel!
    @IBOutlet weak var lbl_StateRef: UILabel!
    @IBOutlet weak var lbl_ZipcodeRef: UILabel!
    @IBOutlet weak var lbl_DescriptionRef: UILabel!
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
