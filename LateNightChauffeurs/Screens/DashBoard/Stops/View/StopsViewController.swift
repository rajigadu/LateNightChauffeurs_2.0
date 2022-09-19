//
//  StopsViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import UIKit

class StopsViewController: UIViewController {
    
    @IBOutlet weak var lbl_StopsFoundRef: UILabel!
    @IBOutlet weak var tableview_StopshistoryRef: UITableView!
    @IBOutlet weak var txt_StoplocationRef: UITextField!
    @IBOutlet weak var addAddressToTFBtn: UIButton!
    @IBOutlet weak var btn_AddStopAddressRef: UIButton!
    @IBOutlet weak var btn_SubmitActionRef: UIButton!
    @IBOutlet weak var btn_SubmitHeghtConstraintRef: NSLayoutConstraint!

    var str_ComingFrom = ""
    var str_SelectedRideID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_AddStopAddressActionRef(_ sender: Any){
        
    }
    
    @IBAction func btn_SubmitActionRef(_ sender: Any){
        
    }

}
