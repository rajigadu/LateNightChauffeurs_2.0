//
//  CancelRideViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import UIKit

class CancelRideViewController: UIViewController {
    
    @IBOutlet weak var textview_DescriptionRef:UITextView!
    @IBOutlet weak var lbl_messageRef:UILabel!
    
    var str_RideID = ""
    var str_ComingFrom = ""
    
    var str_UserID = ""
    var userInfoDict = ""
    var str_CancelRideAmount = ""
    var statusCancelStr = ""
    var str_RideAmount = ""
    var currentDate = ""
    var RideCancelAmountint = ""
    
    lazy var viewModel = {
        CancelRideViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        str_UserID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        self.lbl_messageRef.isHidden = true
        self.title = "Cancel Ride"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm a"
        currentDate = dateFormat.string(from: Date())
        // Do any additional setup after loading the view.
        
        self.CancelRideAmount()
    }
    
    
    @IBAction func btn_CancelActionRef(_sender: Any) {
        self.popToBackVC()
    }
    
    @IBAction func btn_SubmitActionRef(_sender: Any) {
        str_RideAmount = RideCancelAmountint
        if str_RideAmount == "" {
            showAlertWithCancelApi(Message: str_CancelRideAmount, title : "Please confirm cancellation")
        } else {
            str_CancelRideAmount = "$\(str_RideAmount) will be charged for Ride Cancellation."
            showAlertWithCancelApi(Message: str_CancelRideAmount, title : "Please confirm cancellation")
        }
    }
    
    func showAlertWithCancelApi(Message: String, title : String) {
        let alertController = UIAlertController(title: title, message: Message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            self.cancelFutureRideAPI()
        }
        let CacelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
        }
        alertController.addAction(OKAction)
        alertController.addAction(CacelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension CancelRideViewController {
    
    // Cancel Ride
    func cancelFutureRideAPI() {
        indicator.showActivityIndicator()
        let perams = [ "userid":str_UserID,
                       "ride_id":self.str_RideID,
                       "reason":self.textview_DescriptionRef.text ?? "",//str_UserLoginID,
                       "cancel_time":currentDate]
        
        self.viewModel.requestForcancelFutureRideAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.loginStatus == "1" {
                    self.ShowAlertWithDashBoardPage(message : UserData.userData?[0].Message ?? "")
                    } else {
                        self.ShowAlert(message : UserData.userData?[0].Message ?? "")
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
    
    func CancelRideAmount() {
        indicator.showActivityIndicator()
        let perams = [ "ride_id":str_RideID,
                       "cancel_time":currentDate]
        self.viewModel.requestForCancelRideAmountAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.loginStatus == "1" {
                    self.RideCancelAmountint = UserData.cancelAmount ?? ""
                    self.str_RideAmount = self.RideCancelAmountint
                    self.str_CancelRideAmount = "$\(str_RideAmount) will be charged for Ride Cancellation."
                    } else {
                        self.showToast(message: "Something went wrong.", font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}
