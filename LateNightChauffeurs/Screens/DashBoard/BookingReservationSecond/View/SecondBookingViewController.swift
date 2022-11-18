//
//  SecondBookingViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 20/09/22.
//

import UIKit

class SecondBookingViewController: UIViewController {
    
    @IBOutlet weak var promoCodeButtonref: UIButton!
    @IBOutlet weak var PromoApplyBtnref: UIButton!
    @IBOutlet weak var ProMoCodeTf_ref:UITextField!
    
    @IBOutlet weak var cardTble_hightref: NSLayoutConstraint!
    @IBOutlet weak var AddCardBackViewref: UIView!
    @IBOutlet weak var addCardView_ref: UIView!
    @IBOutlet weak var CardName_Tfref: UITextField!
    @IBOutlet weak var cardNumber_Tfref: UITextField!
    @IBOutlet weak var Expiry_MY_Tfref: UITextField!
    @IBOutlet weak var CVV_Tfref: UITextField!
    @IBOutlet weak var PostalCode_Tfref: UITextField!
    @IBOutlet weak var AddCardView_Heaightref: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var DROPDOWNBTNREF: UIButton!
    
    @IBOutlet weak var tableviewHeightref: NSLayoutConstraint!
    lazy var viewModel = {
        SecondBookingViewModel()
    }()
    var array_AvailableCardList: SecondBookingData?
    var dict_SelectedRideDetailsForEdit :RideInfoDatar?
    var arrSelectedSectionIndex:[Int] = []
    var SelectedIndex:[Int] = []
    var str_SelectedAccountID = ""
    var str_SelectedCardID = ""
    var colapsestatus = false
    var cellIndex = 0
    var isMultipleExpansionAllowed = true
    var str_PromoCodeStr = ""
        
    //MARK: - expiry date and year pick
    var expiryMonths: [Int] = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12]
    var expiryYears: [Int] = [22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
    var accountNumber = ""
    var expNumber = ""
    var expMonth = ""
    var expYear = ""
    var postalCode = ""
    var cvvCode = ""
    var name = ""
    var expiryDatePicker: UIPickerView!
    var str_ComingFrom = ""
    
    //step - 6 - creating of global dict
    var bookingModel: BookingModel?
    var bookingModel2: BookingModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if str_ComingFrom == "RideHistory" {
        self.ProMoCodeTf_ref.text = dict_SelectedRideDetailsForEdit?.promo ?? ""
        }
        self.bookingModel2 = self.bookingModel

        self.savedCardListApiCall()
        AddCardView_Heaightref.constant = 0
        addCardView_ref.isHidden = true
        
        //tableView.contentInset = UIEdgeInsets.zero

     
        // tblView.estimatedRowHeight = 1000
        // Do any additional setup after loading the view.
        
        expiryDatePicker = UIPickerView()

        expiryDatePicker.dataSource = self
        expiryDatePicker.delegate = self

        Expiry_MY_Tfref.inputView = expiryDatePicker
        self.expMonth = "\(expiryMonths[0])"
        self.expYear = "\(expiryYears[0])"
        Expiry_MY_Tfref.text = "\(expiryMonths[0])/" + "\(expiryYears[0])"
        
        savedCardListApiCall()
    }
    
    
    @IBAction func addNewCardBtnref(_ sender: Any) {
        UIView.animate(withDuration: 5.90 - 0.3, animations: {
            self.addCardView_ref.isHidden = false
            self.AddCardView_Heaightref.constant = 380
            //  _AddCardView_Heaightref.frame = CGRectOffset(aView.frame, 0, 250);
        })
    }
    
    @IBAction func AddCard_fromSavedCardVC_btnref(_ sender: Any) {
        self.AddCardApiCall()
    }
    
    @IBAction func addNewCardViewClosingBtn(_ sender: Any) {
        UIView.animate(withDuration: 5.90 - 0.3, animations: {
            self.addCardView_ref.isHidden = true
            self.AddCardView_Heaightref.constant = 0
            //  _AddCardView_Heaightref.frame = CGRectOffset(aView.frame, 0, 250);
        })
    }
    
    @IBAction func PromoCoderef(_ sender: Any) {
        promoCodeButtonref.isHidden = true
        ProMoCodeTf_ref.isHidden = false
        PromoApplyBtnref.isHidden = false
    }
    
    @IBAction func PromocodeBtn(_ sender: Any) {
        str_PromoCodeStr = ProMoCodeTf_ref.text ?? "" // your text
        if str_PromoCodeStr.isEmpty {
            self.ShowAlert(message: "Please Enter Promo Code")
        } else {
            self.promoCodeValidationApiCall()
        }
    }
    
    @IBAction func BookMyChauffer(_ sender: Any) {
        if self.str_SelectedCardID == "" {
            self.ShowAlert(message: "Please select payment card.")
        } else {
            if str_ComingFrom == "RideHistory" {
                EditRideApiCall()
            } else {
                createNewRideApiCall()
            }
        }
    }

}
extension SecondBookingViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.array_AvailableCardList?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelectedSectionIndex.contains(section) ? 1 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:BookingsecondFooterCell = tableView.dequeueReusableCell(withIdentifier: "BookingsecondFooterCell", for: indexPath) as? BookingsecondFooterCell else {return UITableViewCell()}
        
        cell.Removebtnref.tag = indexPath.row
        cell.Removebtnref.addTarget(self, action: #selector(btnRemovecard), for: .touchUpInside)
        return cell
    }
    
    @objc func btnRemovecard(sender: Any){
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView:BookingsecondHeaderCell = tableView.dequeueReusableCell(withIdentifier: "BookingsecondHeaderCell") as?  BookingsecondHeaderCell else {return UIView()}
        let cardData = self.array_AvailableCardList?.data?[section]
        let cardNumber = cardData?.token as? String ?? ""
        let showCardNumb = cardNumber.suffix(4) ?? ""
        let ExpiryDate = cardData?.expiry ?? ""
        let yearStr = ExpiryDate.suffix(2) ?? ""
        let monthStr = ExpiryDate.prefix(2) ?? ""
        
        
        print("\(cardData?.accttype ?? "")      XXXXXXX\(showCardNumb)     \(monthStr)/\(yearStr)")
        headerView.CardTypeCardNameref.text =
           "\(cardData?.accttype ?? "")      XXXXXXX\(showCardNumb)     \(monthStr)/\(yearStr)"
        //        headerView.CvvNumberLblref.text = ""
        //        headerView.
        
        
        
        if SelectedIndex.contains(section) {
            headerView.SeletcardBtnref.setImage(UIImage(named: "Circle"), for: .normal)
        } else {
            headerView.SeletcardBtnref.setImage(UIImage(named: "emptyCircle"), for: .normal)
        }
        
        if arrSelectedSectionIndex.contains(section) {
            headerView.btnShowHide.isSelected = true
        }
        
        // Edit Ride Info time select the car
        if  cardData?.acctid ?? "" == dict_SelectedRideDetailsForEdit?.acctid ?? "0" {
            headerView.SeletcardBtnref.setImage(UIImage(named: "Circle"), for: .normal)
            str_SelectedCardID = dict_SelectedRideDetailsForEdit?.card_id ?? ""
            str_SelectedAccountID = dict_SelectedRideDetailsForEdit?.acctid ?? ""
        }
        
        
        headerView.btnShowHide.tag = section
        headerView.btnShowHide.addTarget(self, action: #selector(btnTapShowHideSection), for: .touchUpInside)
        
        headerView.SeletcardBtnref.tag = section
        headerView.SeletcardBtnref.addTarget(self, action: #selector(btnSelectioncard), for: .touchUpInside)
        
        return headerView
        
    }
    
    @objc func btnTapShowHideSection(sender: UIButton) {
        colapsestatus = true
        cellIndex = sender.tag
        
        if arrSelectedSectionIndex.contains(sender.tag) {
            var filtered = arrSelectedSectionIndex.indices.filter {arrSelectedSectionIndex[$0] == sender.tag}
            arrSelectedSectionIndex.remove(at: filtered[0])
            
        } else {
            arrSelectedSectionIndex.append(sender.tag)
        }
        self.tableviewHeightref.constant = CGFloat((self.array_AvailableCardList?.data?.count ?? 0) * 82 + (arrSelectedSectionIndex.count * 50))
        self.tblView.setNeedsLayout()
        self.tblView.reloadData()
    }
    
    @objc func btnSelectioncard(sender: UIButton) {
        SelectedIndex.removeAll()
        SelectedIndex.append(sender.tag)
        str_SelectedCardID = array_AvailableCardList?.data?[sender.tag].token ?? ""
        str_SelectedAccountID = array_AvailableCardList?.data?[sender.tag].acctid ?? ""
        self.tblView.reloadData()
    }
}
extension SecondBookingViewController: UIPickerViewDelegate, UIPickerViewDataSource{
   

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return expiryMonths.count
        } else {
            return expiryYears.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(expiryMonths[row])"
        } else {
            return "\(expiryYears[row])"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("\(expiryMonths[row])")
            self.expMonth = "\(expiryMonths[row])"
        } else {
            print("\(expiryYears[row])")
            self.expYear = "\(expiryYears[row])"
        }
        self.expNumber = self.expMonth + " / " + self.expYear
        self.Expiry_MY_Tfref.text = self.expNumber
    }
}

extension SecondBookingViewController {
    //MARK: - Api Intigration
    func savedCardListApiCall(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForsavedCardListAPIServices(perams: ["userid":userID]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.array_AvailableCardList = UserData
                    // self.tableviewHeightref.constant = CGFloat(80 * (self.array_AvailableCardList?.data?.count ?? 0))
                    self.tblView.reloadData()
                    
                    if colapsestatus {
                        self.tableviewHeightref.constant = CGFloat((self.array_AvailableCardList?.data?.count ?? 0) * 82 + (arrSelectedSectionIndex.count * 50))
                    } else {
                        self.tableviewHeightref.constant = CGFloat((self.array_AvailableCardList?.data?.count ?? 0) * 82)
                     }
                    self.tblView.setNeedsLayout()
                    self.tblView.reloadData()
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

extension SecondBookingViewController {
    //MARK: - Promo Code Api Intigration
    func promoCodeValidationApiCall(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForpromoCodeValidationAPIServices(perams: ["promo":self.str_PromoCodeStr]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: UserData.message ?? "")
                }
            } else if let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: UserData.message ?? "")
                    //                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}

extension SecondBookingViewController {
    //MARK: - Add card Api Intigration
    func AddCardApiCall(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        self.name = self.CardName_Tfref.text ?? ""
        self.accountNumber = self.cardNumber_Tfref.text ?? ""
        self.expNumber = self.expMonth + self.expYear
        self.cvvCode = self.CVV_Tfref.text ?? ""
        self.postalCode = self.PostalCode_Tfref.text ?? ""
        indicator.showActivityIndicator()
        self.viewModel.requestForAddNewCardAPIServices(perams: ["userid":userID,"account":self.accountNumber,"exp":self.expNumber,"postal":self.postalCode,"cvv":self.cvvCode,"name":self.name]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.CardName_Tfref.text = ""
                    self.cardNumber_Tfref.text = ""
                    self.Expiry_MY_Tfref.text = ""
                    self.CVV_Tfref.text = ""
                    self.PostalCode_Tfref.text = ""

                    self.ShowAlert(message: UserData.message ?? "")
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

extension SecondBookingViewController {
    //MARK: - createNewRide
    func createNewRideApiCall(){
        guard let strPromoCode = self.ProMoCodeTf_ref.text else{ return }
        guard let userid = self.bookingModel2?.userid as? String else {return}
        guard let card_id = self.str_SelectedCardID as? String else {return}
        guard let acctid = self.str_SelectedAccountID as? String else {return}
        guard let nstops = self.bookingModel2?.nstops as? String else {return}
        guard let savedrop = self.bookingModel2?.savedrop as? [String] else {return}
        guard let platitude = self.bookingModel2?.platitude as? String else {return}
        guard let plongitude = self.bookingModel2?.plongitude as? String else {return}
        guard let pickup_address = self.bookingModel2?.pickup_address as? String else {return}
        guard let pickup_city = self.bookingModel2?.pickup_city as? String else {return}
        guard let drop_address = self.bookingModel2?.drop_address as? String else {return}
        guard let dlatitude = self.bookingModel2?.dlatitude as? String else {return}
        guard let dlongitude = self.bookingModel2?.dlongitude as? String else {return}
        guard let drop_city = self.bookingModel2?.drop_city as? String else {return}
        guard let notes = self.bookingModel2?.notes as? String else {return}
        guard let booking_type = self.bookingModel2?.booking_type as? String else {return}
        guard let date = self.bookingModel2?.date as? String else {return}
        guard let time = self.bookingModel2?.time as? String else {return}
        guard let transmission = self.bookingModel2?.transmission as? String else {return}
 
        let perams = [
            "userid": userid,
            "card_id": card_id,
            "acctid": acctid,
            "nstops": nstops,
            "savedrop": savedrop,
            "platitude": platitude,
            "plongitude": plongitude,
            "pickup_address": pickup_address,
            "pickup_city": pickup_city,
            "drop_address": drop_address,
            "dlatitude": dlatitude,
            "dlongitude": dlongitude,
            "drop_city": drop_city,
            "notes": notes,
            "booking_type": booking_type,
            "date": date,
            "time": time,
            "transmission": transmission,
            "promo": strPromoCode,
            "version": "yes"
        ] as? [String: Any]
        var peram2 = savedrop as? [String]
        var allStops : [String] = []
        for peram in savedrop {
            allStops.append(peram.removeWhitespace())
        }
        
        var str1 = json(from: perams) ?? ""
        var str2 = json(from: peram2) ?? ""
        
        indicator.showActivityIndicator()
        self.viewModel.requestForcreateNewRideAPIServices(perams: ["json":str1.removeWhitespace(), "jsonstops":allStops]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        UserDefaults.standard.set(UserData.data?[0].ride_id ?? "", forKey: "OnGoingRequestID")
                        UserDefaults.standard.set("RideRequestProcessing", forKey: "RideRequestProcessingCheck")
                        
                        self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard", animated: true)
                    } else if UserData.status == "3" {
                        self.ShowAlertWithPUSH(message : UserData.data?[0].message ?? "",id:"RideHistoryViewController",storyBordid : "Profile",animated:true)
                    } else if UserData.status == "0" {
                        let message1 = "Congratulations! your reservation has been completed."
                        let message2 = "‣ Reservation is Subject to Our availability."
                        let message3 = "‣ Wait time = $10/15min."
                        let message4 = "‣ Unplanned stops = $10."
                        let message5 = "‣ Price does not include gratuity."
                        let message  = message1 + message2 + message3 + message4 + message5
                        let str_MessageTitle = UserData.data?[0].message ?? ""
                        if str_MessageTitle == "Congratulations! your reservation has been completed." {
                            self.ShowAlertWithRideInfoPage(message : message)
                        } else {
                            self.ShowAlertWithDashBoardPage(message: str_MessageTitle)
                        }
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


extension SecondBookingViewController {
    //MARK: - Edit Ride
    func EditRideApiCall(){
        guard let strPromoCode = self.ProMoCodeTf_ref.text else{ return }
        guard let userid = self.bookingModel2?.userid as? String else {return}
        guard let card_id = self.str_SelectedCardID as? String else {return}
        guard let acctid = self.str_SelectedAccountID as? String else {return}
        guard let nstops = self.bookingModel2?.nstops as? String else {return}
        guard let savedrop = self.bookingModel2?.savedrop as? [String] else {return}
        guard let platitude = self.bookingModel2?.platitude as? String else {return}
        guard let plongitude = self.bookingModel2?.plongitude as? String else {return}
        guard let pickup_address = self.bookingModel2?.pickup_address as? String else {return}
        guard let pickup_city = self.bookingModel2?.pickup_city as? String else {return}
        guard let drop_address = self.bookingModel2?.drop_address as? String else {return}
        guard let dlatitude = self.bookingModel2?.dlatitude as? String else {return}
        guard let dlongitude = self.bookingModel2?.dlongitude as? String else {return}
        guard let drop_city = self.bookingModel2?.drop_city as? String else {return}
        guard let notes = self.bookingModel2?.notes as? String else {return}
        guard let booking_type = self.bookingModel2?.booking_type as? String else {return}
        guard let date = self.bookingModel2?.date as? String else {return}
        guard let time = self.bookingModel2?.time as? String else {return}
        guard let transmission = self.bookingModel2?.transmission as? String else {return}
        guard let bookingID = self.dict_SelectedRideDetailsForEdit?.id as? String else {return}

        let perams = [
            "booking_id":bookingID,
            "userid": userid,
            "card_id": card_id,
            "acctid": acctid,
            "nstops": nstops,
            "savedrop": savedrop,
            "platitude": platitude,
            "plongitude": plongitude,
            "pickup_address": pickup_address,
            "pickup_city": pickup_city,
            "drop_address": drop_address,
            "dlatitude": dlatitude,
            "dlongitude": dlongitude,
            "drop_city": drop_city,
            "notes": notes,
            "booking_type": booking_type,
            "date": date,
            "time": time,
            "transmission": transmission,
            "promo": strPromoCode,
            "version": "yes"
        ] as? [String: Any]
        var peram2 = savedrop as? [String]
        var allStops : [String] = []
        for peram in savedrop {
            allStops.append(peram.removeWhitespace())
        }
        
        var str1 = json(from: perams) ?? ""
        var str2 = json(from: peram2) ?? ""
        
        indicator.showActivityIndicator()
        self.viewModel.requestForEditRideAPIServices(perams: ["json":str1.removeWhitespace(), "jsonstops":allStops]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        UserDefaults.standard.set(UserData.data?[0].ride_id ?? "", forKey: "OnGoingRequestID")
                        UserDefaults.standard.set("RideRequestProcessing", forKey: "RideRequestProcessingCheck")
                        self.ShowAlertWithDashBoardPage(message: "Success")
                        //self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard", animated: true)
                    } else if UserData.status == "3" {
                        self.ShowAlertWithRideInfoPage(message: UserData.data?[0].message ?? "")
                    } else if UserData.status == "0" {
                        let message1 = "Congratulations! your reservation has been completed."
                        let message2 = "‣ Reservation is Subject to Our availability."
                        let message3 = "‣ Wait time = $10/15min."
                        let message4 = "‣ Unplanned stops = $10."
                        let message5 = "‣ Price does not include gratuity."
                        let message  = message1 + message2 + message3 + message4 + message5
                        let str_MessageTitle = UserData.data?[0].message ?? ""
                        
                        if str_MessageTitle == "Congratulations! your reservation has been completed." {
                            self.ShowAlertWithRideInfoPage(message : str_MessageTitle)
                        } else {
                            self.ShowAlertWithDashBoardPage(message: str_MessageTitle)
                        }
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
