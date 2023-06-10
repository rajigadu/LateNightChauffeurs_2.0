//
//  DBH_RideHistoryTableViewCell.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 14/03/23.
//

import Foundation
import UIKit

class DBH_RideHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_JourneyDateRef:UILabel!
    //@property (weak, nonatomic) IBOutlet UILabel *lbl_NoofStopRef;
    @IBOutlet weak var lbl_PickUpLocationRef:UILabel!
    @IBOutlet weak var lbl_DropLocationRef:UILabel!
    @IBOutlet weak var lbl_DistanceRef:UILabel!
    @IBOutlet weak var btn_PaymentRef:UIButton!
    @IBOutlet weak var GiveFeedBackBtnref:UIButton!
    @IBOutlet weak var GIVeFeedBackHeightRef:NSLayoutConstraint!

    @IBOutlet weak var AddTipAmountBtnref:UIButton!
    @IBOutlet weak var AddtipAmountHeightbtnref:NSLayoutConstraint!

    @IBOutlet weak var btn_StopsRef:UIButton!
    @IBOutlet weak var btn_PaymentConstraintRef:NSLayoutConstraint!

    @IBOutlet weak var feedBackHeightref: NSLayoutConstraint!
    
    @IBOutlet weak var TipAmountheghtref: NSLayoutConstraint!
    @IBOutlet weak var view_FutureRideRef:UIView!
    @IBOutlet weak var btn_FutureRideRef:UIButton!
    @IBOutlet weak var lbl_DateRef:UILabel!
    @IBOutlet weak var lbl_RideInfoRef:UILabel!
    @IBOutlet weak var lbl_RideDistanceRef:UILabel!
    @IBOutlet weak var lbl_RideStatusRef:UILabel!
    @IBOutlet weak var btn_ViewDetailRef:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
