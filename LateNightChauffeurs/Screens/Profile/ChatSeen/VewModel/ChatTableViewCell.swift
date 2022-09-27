//
//  ChatTableViewCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var SenmsgRef: UILabel!
    @IBOutlet weak var SendateRef: UILabel!
    @IBOutlet weak var SenprofileImgRef: UIImageView!
    @IBOutlet weak var senBagRef: UIImageView!
    @IBOutlet weak var ResmsgRef: UILabel!
    @IBOutlet weak var ResdateRef: UILabel!
    @IBOutlet weak var ResprofileImgRef:UIImageView!
    @IBOutlet weak var ResbagRef: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
