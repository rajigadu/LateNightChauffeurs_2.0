//
//  RideHistoryTipViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import UIKit

class RideHistoryTipViewController: UIViewController {

   var dict_RideCompletedResponse = Dictionary<String,Any>()
   var str_UserIDr = ""
   var str_RideIDr = ""
   var str_ComingFrom = ""
   var str_SelectedDriverFirstNameget = ""
   var str_SelectedDriverLastNameget = ""
   var str_SelectedDriverProfilepicget = ""

    @IBOutlet weak var txt_TipAmountRef:UITextField!
    @IBOutlet weak var imageview_DriverForFeedbackRef:UIImageView!
    @IBOutlet weak var lbl_DriverNameForFeedbackRef:UILabel!
    @IBOutlet weak var collectionview_TipPercentageListRef:UICollectionView!
    @IBOutlet weak var btn_ClearButtonHeightConstraint:NSLayoutConstraint!
    
     var str_UserLoginID = ""
    var str_DriverID = ""
    var str_CurrentRideID = ""
    var ary_TipPercentageList :[String] = ["15%","20%","25%"]
    var percentages = ["15","20","25"]
    var ary_TipPercentageList2 :Int = -1
    var str_RatingValue = ""
    var str_SelectedPercentage = ""
    var  selectedIndex = 0
    var str_SelectedTipOption = ""
    var Str_DriverCmgHistory = ""
    var vcCmgFrom = ""  
    lazy var viewModel = {
        RideHistoryTipViewModel()
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " Gratuity"
        str_RatingValue = ""
        str_SelectedTipOption = ""
        self.imageview_DriverForFeedbackRef.layer.cornerRadius = 20
        self.imageview_DriverForFeedbackRef.layer.borderWidth = 1
        self.imageview_DriverForFeedbackRef.layer.borderColor = UIColor.white.cgColor
        self.imageview_DriverForFeedbackRef.layer.masksToBounds = true
        str_UserLoginID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""

        if str_ComingFrom == "RideHistory" {
            str_CurrentRideID = str_RideIDr
            str_DriverID = Str_DriverCmgHistory
            Str_DriverCmgHistory = str_UserIDr
            
            self.lbl_DriverNameForFeedbackRef.text = str_SelectedDriverFirstNameget + str_SelectedDriverLastNameget
            if let profileImage = str_SelectedDriverProfilepicget as? String {
                self.imageview_DriverForFeedbackRef.sd_setImage(with: URL(string: API_URl.API_BASEIMAGE_URL +  str_SelectedDriverProfilepicget ?? ""), placeholderImage: UIImage(named: "UserPic"))
            }

        }
        // Do any additional setup after loading the view.
        if vcCmgFrom == "AppDelegate" {
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(backToMenu))

        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backToDashboard))
            navigationController?.navigationBar.barTintColor = UIColor.black

        }

   }
  
    @objc func backToMenu() {
        self.navigateToSideMenu()
    }

    @objc func backToDashboard() {
        self.popToBackVC()
    }

    
    @IBAction func btn_DriverForSubmitFeedbackRef(_ sender: Any) {
        if str_SelectedTipOption == "" {
            self.ShowAlert(message: "Please select tip option")
        } else {
            self.paymentSummaryAPI()
        }
    }
    
    @IBAction func btn_ClearActionRef(_ sender: Any) {
         if self.txt_TipAmountRef.text?.count ?? 0 == 0 {
             str_SelectedTipOption = ""
         } else {
             str_SelectedTipOption = "2"
         }
        self.ary_TipPercentageList2 = -1
        str_SelectedPercentage = ""
        self.collectionview_TipPercentageListRef.reloadData()
    }
    
}
extension RideHistoryTipViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ary_TipPercentageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TipPercentageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipPercentageCollectionViewCell", for: indexPath) as! TipPercentageCollectionViewCell
        cell.lbl_TipPercentageRef.text = ary_TipPercentageList[indexPath.row]
        cell.btn_RadioButtonRef.tag = indexPath.row
        cell.btn_RadioButtonRef.addTarget(self, action: #selector(radioButtonClicked), for: .touchUpInside)
        if ary_TipPercentageList2 == indexPath.row {
            cell.btn_RadioButtonRef.setImage(UIImage(named: "Circle"), for: .normal)
        } else {
            cell.btn_RadioButtonRef.setImage(UIImage(named: "emptyCircle"), for: .normal)
        }
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.collectionview_TipPercentageListRef.frame.size.width
        let cellWidth: CGFloat = screenWidth / 4
        let cellHeight: CGFloat = self.collectionview_TipPercentageListRef.frame.size.height
        let size: CGSize = CGSize(width: cellWidth, height: cellHeight)
        return size
    }

    
    @objc func radioButtonClicked(sender: UIButton) {
        self.txt_TipAmountRef.text = ""
        str_SelectedTipOption = "1"
        str_SelectedPercentage = percentages[sender.tag]
        ary_TipPercentageList2 = sender.tag
//        if ary_TipPercentageList2.contains(sender.tag) {
//            let filtered = ary_TipPercentageList2.indices.filter {ary_TipPercentageList2[$0] == sender.tag}
//            ary_TipPercentageList2.remove(at: filtered[0])
//
//        } else {
//            ary_TipPercentageList2.append(sender.tag)
//        }

        self.collectionview_TipPercentageListRef.reloadData()
    }
    
}

extension RideHistoryTipViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        str_SelectedTipOption = "2"
        ary_TipPercentageList2 = -1
        self.collectionview_TipPercentageListRef.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ary_TipPercentageList2 = -1
        self.collectionview_TipPercentageListRef.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ary_TipPercentageList2 = -1
        self.collectionview_TipPercentageListRef.reloadData()
        return true
    }
}
extension RideHistoryTipViewController {
    //MARK: - Api Intigration
    func paymentSummaryAPI(){
        let txt_TipAmount = self.txt_TipAmountRef.text ?? ""
        indicator.showActivityIndicator()
        
       let perams = [ "driverid":Str_DriverCmgHistory,
        "rideid":str_CurrentRideID,
        "userid":str_UserLoginID,
        "msg":"",
        "tip":"",
        "percentage":str_SelectedPercentage,
        "amount":txt_TipAmount,
        "rating":str_RatingValue ]
        self.viewModel.requestForSubmitFeedBackAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.loginStatus == "1" {
                    self.ShowAlertWithPop(message: UserData.userData?[0].Message ?? "Your tip has been submitted.")
                    } else {
                        self.ShowAlertWithPop(message: UserData.userData?[0].Message ?? "no records found.")
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
