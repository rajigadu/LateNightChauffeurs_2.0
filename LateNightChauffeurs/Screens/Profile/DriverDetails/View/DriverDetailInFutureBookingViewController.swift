//
//  DriverDetailInFutureBookingViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 26/09/22.
//

import UIKit
import Cosmos

class DriverDetailInFutureBookingViewController: UIViewController {
    
    @IBOutlet weak var view_DriverDetailsRef:UIView!
    @IBOutlet weak var lbl_RideStatusRef: UILabel!
    @IBOutlet weak var lbl_ChatNotificationRef: UILabel!
    @IBOutlet weak var imageview_DriverRef: UIImageView!
    @IBOutlet weak var lbl_DriverNameRef: UILabel!
    @IBOutlet weak var lbl_DriverMobileRef: UILabel!
    @IBOutlet weak var view_RatingViewRef: CosmosView!
    @IBOutlet weak var lbl_DistanceRef: UILabel!
    @IBOutlet weak var lbl_EstimatedPriceRef: UILabel!
    @IBOutlet weak var btn_CancelRideRef: UIButton!
    @IBOutlet weak var lbl_FuturerRideStartStatus: UILabel!
    @IBOutlet weak var view_CancelRideRef: UIView!
    @IBOutlet weak var textview_DescriptionRef: UITextView!

    var str_FutureRideID = ""
    var str_FutureRideDate = ""
    var str_FutureRideTime = ""
    var str_FutureRideStatus = ""
    var str_UserID = ""
    var str_CurrentRideDriverMobileNo = ""
    var str_CurrentRideDriverID = ""
    
    lazy var viewModel = {
        DriverDetailInFutureBookingViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ride Details"
        self.lbl_ChatNotificationRef.isHidden = true
        self.imageview_DriverRef.layer.cornerRadius = 20
        self.imageview_DriverRef.layer.borderWidth = 1
        self.imageview_DriverRef.layer.borderColor = UIColor.white.cgColor
        self.imageview_DriverRef.layer.masksToBounds = true
        str_UserID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        if self.str_FutureRideStatus == "0" {
            self.view_DriverDetailsRef.isHidden = true
            self.lbl_RideStatusRef.isHidden = false
            self.lbl_RideStatusRef.text = "Ride Status : Processing"
        } else {
            self.lbl_RideStatusRef.isHidden = true
            self.view_DriverDetailsRef.isHidden = true

            //API Calling...........
            self.futureRideDriverDetailsAPIwithLogin()

        }
    }
    
    @IBAction func btn_ChatActionRef(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        nxtVC.str_DriverID = self.str_CurrentRideDriverID
        self.navigationController?.pushViewController(nxtVC, animated: true)

    }
    
    @IBAction func btn_CallActionRef(_ sender: Any) {
        if str_CurrentRideDriverMobileNo != "" || str_CurrentRideDriverMobileNo != nil {
            self.dialNumber(number: str_CurrentRideDriverMobileNo)
        }
        
    }
    
    @IBAction func btn_CancelFutureRideActionRef(_ sender: Any) {
//        let alertController = UIAlertController(title: kApptitle, message: "Ride canceled successfully please note if you are cancelling within four hours you are subject to being billed for your ride. To keep the ride please press cancel", preferredStyle: .alert)
//        let OKAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
//            //self.dismiss()
//            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
//            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "CancelRideViewController") as! CancelRideViewController
//            nxtVC.str_RideID = self.str_FutureRideID
//            nxtVC.str_ComingFrom = "FutureRide"
//            self.navigationController?.pushViewController(nxtVC, animated: true)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
//        }
//        alertController.addAction(OKAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func btn_SubmitFutureRideActionRef(_ sender: Any) {
        
    }
    
    @IBAction func btn_CancelRideActionRef(_ sender: Any) {
        let alertController = UIAlertController(title: kApptitle, message: "Ride canceled successfully please note if you are cancelling within four hours you are subject to being billed for your ride. To keep the ride please press cancel", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            //self.dismiss()
            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "CancelRideViewController") as! CancelRideViewController
            nxtVC.str_RideID = self.str_FutureRideID
            nxtVC.str_ComingFrom = "FutureRide"
            self.navigationController?.pushViewController(nxtVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
        }
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }

}

extension DriverDetailInFutureBookingViewController {
    //Ride Details get
   
    //MARK: - Api Intigration
    func futureRideDriverDetailsAPIwithLogin(){
         indicator.showActivityIndicator()
//       let perams = [ "user_id":str_UserID,"ride_id":self.str_FutureRideID]
        let perams = [ "user_id":str_UserID,"ride_id":self.str_FutureRideID]
        self.viewModel.requestForDriverDetailInFutureBookingAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        self.view_DriverDetailsRef.isHidden = false
                        //Driver Details....
                        str_CurrentRideDriverID = UserData.data?.driver?.id ?? ""
                        //profile
                        if let str_DriverImageRef = UserData.data?.driver?.profile_pic as? String {
                            self.imageview_DriverRef.sd_setImage(with: URL(string: API_URl.API_BASEIMAGE_URL +  str_DriverImageRef), placeholderImage: UIImage(named: "UserPic"))
                        } else {
                            self.imageview_DriverRef.image = UIImage(named: "personIcon")
                        }
                        //First Name and Last Name
                        self.lbl_DriverNameRef.text = "Driver Name : " + (UserData.data?.driver?.first_name ?? "") +  (UserData.data?.driver?.last_name ?? "")
                        // Mobile
                        self.str_CurrentRideDriverMobileNo = UserData.data?.driver?.mobile ?? ""
                        self.lbl_DriverMobileRef.text = "Mobile No : " + self.str_CurrentRideDriverMobileNo
                        
                        
                        //Ride Info Details............
                        
                        let str_FutureRideStart = UserData.data?.ride?.future_ride_start ?? ""
                        if str_FutureRideStart == "1" {
                            self.lbl_FuturerRideStartStatus.isHidden = false
                            self.lbl_FuturerRideStartStatus.text = "Ride Started Driver"
                        } else {
                            self.lbl_FuturerRideStartStatus.isHidden = true
                        }
                        // Ride Details
                        self.str_FutureRideDate = UserData.data?.ride?.otherdate ?? ""
                        self.str_FutureRideTime = UserData.data?.ride?.time ?? ""
                        
                        self.lbl_EstimatedPriceRef.text = "Future Ride Date:" + self.str_FutureRideDate + " " + self.str_FutureRideTime
                        
                        //Ride Distance
                        if var RideDistance =  UserData.data?.ride?.distance as? String {
                            if let RideDistanceDouble = Double(RideDistance) {
                                if let RideDistanceFloat = Float(RideDistanceDouble) as? Float {
                                    RideDistance = String(RideDistanceFloat)
                                }
                            }

                            let AttributeStr = "Distance : " + RideDistance + " Miles"
                            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                            let nsRange = NSString(string: AttributeStr).range(of: "Distance :", options: String.CompareOptions.caseInsensitive)
                            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                            self.lbl_DistanceRef.attributedText = attrStri
                        }
                        
                        //Rating...
                        self.view_RatingViewRef.rating = 0
                        
                        if let rating = UserData.data?.driver_rating, rating != "NAN" {
                            self.view_RatingViewRef.rating = Double(rating) ?? 0.00
                        }
                        
                    } else {
                        self.view_DriverDetailsRef.isHidden = true
                        self.lbl_RideStatusRef.text = UserData.message ?? ""
                        self.ShowAlert(message: UserData.message ?? "")
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
