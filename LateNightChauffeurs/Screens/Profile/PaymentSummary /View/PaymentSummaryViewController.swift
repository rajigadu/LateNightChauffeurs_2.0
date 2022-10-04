//
//  PaymentSummaryViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import UIKit

class PaymentSummaryViewController: UIViewController {

    @IBOutlet weak var lbl_TransactionIDRef:UILabel!
    @IBOutlet weak var lbl_BasePriceRef:UILabel!
    @IBOutlet weak var lbl_WaitingTimeref:UILabel!
    @IBOutlet weak var lbl_UnplanedStopsref:UILabel!
    @IBOutlet weak var lbl_planedStopsref:UILabel!
    @IBOutlet weak var lbl_Adminfareref:UILabel!
    @IBOutlet weak var lbl_TipRef:UILabel!
    @IBOutlet weak var lbl_FinalPriceRef:UILabel!

    @IBOutlet weak var lbl_TransactionIDRef2:UILabel!
    @IBOutlet weak var lbl_BasePriceRef2:UILabel!
    @IBOutlet weak var lbl_WaitingTimeref2:UILabel!
    @IBOutlet weak var lbl_UnplanedStopsref2:UILabel!
    @IBOutlet weak var lbl_planedStopsref2:UILabel!
    @IBOutlet weak var lbl_Adminfareref2:UILabel!
    @IBOutlet weak var lbl_TipRef2:UILabel!
    @IBOutlet weak var lbl_FinalPriceRef2:UILabel!

    @IBOutlet weak var CancelLbelref:UILabel!
    @IBOutlet weak var lblpromocoderef:UILabel!
    @IBOutlet weak var btn_OkRef:UIButton!
    
    var Str_BAsePrice = ""
    var Str_Totalfare = ""
    var PaymentInfoDict:PaymentSummaryDatar?
    
    lazy var viewModel = {
        PaymentSummaryViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let str_RideStatus = PaymentInfoDict?.status ?? ""
        let str_TransactionID = PaymentInfoDict?.transaction_id ?? "0"
        self.lbl_TransactionIDRef.text = str_TransactionID

        if str_RideStatus == "2" {
            self.btn_OkRef.layer.cornerRadius = 5.0
            self.btn_OkRef.layer.masksToBounds = true
            self.lbl_TransactionIDRef.isHidden = false
            self.lbl_BasePriceRef.isHidden = false
            self.lbl_WaitingTimeref.isHidden = false
            self.lbl_UnplanedStopsref.isHidden = false
            self.lbl_planedStopsref.isHidden = false
            //self.lbl_Adminfareref.isHidden = false
            self.lbl_TipRef.isHidden = false
            self.lbl_FinalPriceRef.isHidden = false
           self.CancelLbelref.isHidden = true
            self.lblpromocoderef.isHidden = false
            
            // str_AdmnFare
            let str_AdmnFare = PaymentInfoDict?.extra_charge ?? "0"
            if str_AdmnFare == "" {
                self.lbl_Adminfareref.text = ""
            } else {
                //self.lbl_Adminfareref.text = str_AdmnFare
            }
            // base Price
            var result : Int = Int(Str_BAsePrice) ?? 0
            result += Int(str_AdmnFare) ?? 0
            
            self.lbl_BasePriceRef.text = ": $" + String(result)
            
            // Total fare
            self.lbl_FinalPriceRef.text = ": $" + Str_Totalfare
            
            // Promo Code
            let str_PromoCode = PaymentInfoDict?.promo_amt ?? "0"
            self.lblpromocoderef.text = ": $" + str_PromoCode
            
            // waiingTime
            let str_WaitingCharges =  PaymentInfoDict?.unplaned_waiting_amt ?? "0"
            self.lbl_WaitingTimeref.text = ": $" + str_WaitingCharges
            
            // planed Stops
            let str_planedStops = PaymentInfoDict?.planed_stop_amt ?? "0"
            self.lbl_planedStopsref.text = ": $" + str_planedStops
            
            // str_unplanedStops
            let str_unplanedStops = PaymentInfoDict?.unplaned_stop_amt ?? "0"
            self.lbl_UnplanedStopsref.text = ": $" + str_unplanedStops
            
            // tip Amount
            let str_Tip = PaymentInfoDict?.tip_amount ?? "0"
            self.lbl_TipRef.text = ": $" + str_Tip
        } else {
            self.lbl_TransactionIDRef.isHidden = true
            self.lbl_BasePriceRef.isHidden = true
            self.lbl_WaitingTimeref.isHidden = true
            self.lbl_UnplanedStopsref.isHidden = true
            self.lbl_planedStopsref.isHidden = true
            //self.lbl_Adminfareref.isHidden = true
            self.lbl_TipRef.isHidden = true
            self.lbl_FinalPriceRef.isHidden = true
            self.lbl_TransactionIDRef2.isHidden = true
            self.lbl_BasePriceRef2.isHidden = true
            
            self.lbl_WaitingTimeref2.isHidden = true
            self.lbl_UnplanedStopsref2.isHidden = true
            self.lbl_planedStopsref2.isHidden = true
            //self.lbl_Adminfareref2.isHidden = true
            self.lbl_TipRef2.isHidden = true
            self.lbl_FinalPriceRef2.isHidden = true
            self.CancelLbelref.isHidden = false
            self.lblpromocoderef.isHidden = true
            
            let str_BasePrice = PaymentInfoDict?.ride_amt ?? "0"
            self.CancelLbelref.text = "Ride Cancellation Amount : $" + str_BasePrice

        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    @IBAction func btn_OkRef(_ sender: Any) {
        self.popToBackVC()
    }

}
