//
//  RiseHistoryFeedBackViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import UIKit
import Cosmos
class RiseHistoryFeedBackViewController: UIViewController {

    var dict_RideCompletedResponse = Dictionary<String,Any>()
    var str_UserIDr = ""
    var str_RideIDr = ""
    var str_ComingFrom = ""
    var str_SelectedDriverFirstNameget = ""
    var str_SelectedDriverLastNameget = ""
    var str_SelectedDriverProfilepicget = ""

    @IBOutlet weak var imageview_DriverForFeedbackRef:UIImageView!
    @IBOutlet weak var lbl_DriverNameForFeedbackRef:UILabel!
    @IBOutlet weak var viewRating_DriverForFeedbackRef:CosmosView!
    @IBOutlet weak var textview_DriverForFeedbackRef:UITextView!


    var ary_StopsRef = Dictionary<String,Any>()
    var str_UserLoginID = ""
    var str_DriverID = ""
    var str_CurrentRideID = ""
    var ary_TipPercentageList = Dictionary<String,Any>()
    var str_RatingValue = ""
    var str_SelectedPercentage = ""
    var selectedIndex = 0
    var str_SelectedTipOption = ""
    // NSString * UserDriverID;
    var Str_DriverCmgHistory = ""
    
    lazy var viewModel = {
        RideHistoryTipViewModel()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Gratuity"
        str_RatingValue = ""
        str_SelectedTipOption = ""
        self.cosmosViewSetUP()
        self.imageview_DriverForFeedbackRef.layer.cornerRadius = 20
        self.imageview_DriverForFeedbackRef.layer.borderWidth = 1
        self.imageview_DriverForFeedbackRef.layer.borderColor = UIColor.white.cgColor
        self.imageview_DriverForFeedbackRef.layer.masksToBounds = true
        str_UserLoginID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        // Do any additional setup after loading the view.
        if str_ComingFrom == "RideHistory" {
            str_CurrentRideID = str_RideIDr
            str_DriverID = Str_DriverCmgHistory
            Str_DriverCmgHistory = str_UserIDr
            
            self.lbl_DriverNameForFeedbackRef.text = str_SelectedDriverFirstNameget + str_SelectedDriverLastNameget
            if let profileImage = str_SelectedDriverProfilepicget as? String {
                self.imageview_DriverForFeedbackRef.sd_setImage(with: URL(string: API_URl.API_BASEIMAGE_URL +  profileImage), placeholderImage: UIImage(named: "UserPic"))
            }

        }

    }
    
    func cosmosViewSetUP(){
        // Change the cosmos view rating
        viewRating_DriverForFeedbackRef.rating = 5

        // Change the text
       // viewRating_DriverForFeedbackRef.text = "(123)"

        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        viewRating_DriverForFeedbackRef.didFinishTouchingCosmos = { rating in
            self.str_RatingValue = "\(rating)"
        }

        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        viewRating_DriverForFeedbackRef.didTouchCosmos = { rating in
            
        }

    }

    @IBAction func btn_DriverForSubmitFeedbackRef(_ sender: Any) {
        if str_RatingValue == "" {
            self.ShowAlert(message: "Please give me Rating for Driver")
        } else {
            paymentSummaryAPI()
        }
    }

}
extension RiseHistoryFeedBackViewController {
    //MARK: - Api Intigration
    func paymentSummaryAPI(){
         indicator.showActivityIndicator()
        var discription = self.textview_DriverForFeedbackRef.text ?? ""
       let perams = [ "driverid":Str_DriverCmgHistory,
        "rideid":str_CurrentRideID,
        "userid":"701",//str_UserLoginID,
        "msg":discription,
        "tip":"",
        "percentage":"",
        "amount":"",
        "rating":str_RatingValue ]
        self.viewModel.requestForSubmitFeedBackAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlertWithPop(message: UserData.userData?[0].Message ?? "Your tip has been submitted.")
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}
