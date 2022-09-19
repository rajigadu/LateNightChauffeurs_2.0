//
//  CancelBookingViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import UIKit

class CancelBookingViewController: UIViewController {
    
    
    @IBOutlet weak var textview_DescriptionRef: UITextView!
    @IBOutlet weak var lbl_messageRef:UILabel!
    
    var  str_RideID = ""
    var str_ComingFrom = ""
    
    var str_UserID = ""
    var userInfoDict = Dictionary<String,Any>()
    var str_CancelRideAmount = ""
    var statusCancelStr = ""
    var str_RideAmount = ""
    var currentDate = ""
    var RideCancelAmountint = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let userID = UserDefaults.standard.string(forKey: "UserLoginID") {
        self.str_UserID = userID
        }
        self.lbl_messageRef.isHidden = true
        self.title = "Cancel Ride"
    }

}
