//
//  AvilableCardsViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 23/09/22.
//

import UIKit

class AvilableCardsViewController: UIViewController {
    
    @IBOutlet weak var tableview_SavedCardsRef: UITableView!
    @IBOutlet weak var lbl_SavedcardRef: UILabel!
    @IBOutlet weak var btn_AddCardRef: UIButton!
    //new card
    @IBOutlet weak var addCardView_ref: UIView!
    @IBOutlet weak var CardName_Tfref: UITextField!
    @IBOutlet weak var cardNumber_Tfref: UITextField!
    @IBOutlet weak var Expiry_MY_Tfref: UITextField!
    @IBOutlet weak var CVV_Tfref: UITextField!
    @IBOutlet weak var PostalCode_Tfref: UITextField!
    @IBOutlet weak var AddCardView_Heaightref: NSLayoutConstraint!
    
    @IBOutlet weak var DROPDOWNBTNREF: UIButton!
    
    lazy var viewModel = {
        AvilableCardViewMode()
    }()
    var array_AvailableCardList: SecondBookingData?
    var array_AvailableCardListr :[SecondBookingDatar] = []
    //MARK: - expiry date and year pick
    var expiryMonths: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var expiryYears: [Int] = [22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
    var accountNumber = ""
    var expNumber = ""
    var expMonth = ""
    var expYear = ""
    var postalCode = ""
    var cvvCode = ""
    var name = ""
    var str_SelectedAccountID = ""
    var str_SelectedCardID = ""
    var expiryDatePicker: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available Cards"
        self.lbl_SavedcardRef.isHidden = true
       // self.tableview_SavedCardsRef.isHidden = true
        self.btn_AddCardRef.layer.cornerRadius = 5.0
        self.btn_AddCardRef.layer.masksToBounds = true
        AddCardView_Heaightref.constant = 0;
        // Do any additional setup after loading the view.
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .up
        self.view.addGestureRecognizer(swipeRight)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        
        expiryDatePicker = UIPickerView()

        expiryDatePicker.dataSource = self
        expiryDatePicker.delegate = self
        
        Expiry_MY_Tfref.inputView = expiryDatePicker
        self.expMonth = "\(expiryMonths[0])"
        self.expYear = "\(expiryYears[0])"
        expNumber = self.expMonth + "/" + self.expYear
        Expiry_MY_Tfref.text = "\(expiryMonths[0])/" + "\(expiryYears[0])"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.savedCardListApiCall()
    }


    @objc override func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                
            case .down:
                print("Swiped down")
                AddCardView_Heaightref.constant = 0
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
                AddCardView_Heaightref.constant = 408
            default:
                break
            }
        }
    }
    
    @IBAction func SideMenuOpen(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
    @IBAction func btn_AddCardActionRef(_ sender: Any) {
        AddCardView_Heaightref.constant = 408
    }
    
    @IBAction func DROPDOWNBTNREF(_ sender: Any) {
        AddCardView_Heaightref.constant = 0
    }
    
    @IBAction func AddCard_fromSavedCardVC_btnref(_ sender: Any) {
        AddCardApiCall()
    }
    
}
extension AvilableCardsViewController {
    //MARK: - Add card Api Intigration
    func AddCardApiCall(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        self.name = self.CardName_Tfref.text ?? ""
        self.accountNumber = self.cardNumber_Tfref.text ?? ""
        if self.expMonth.count == 1 {
            var rexpMonth = "0" + expMonth
            self.expMonth = rexpMonth
        }
        self.expNumber = self.expMonth + "/" +  self.expYear
        self.cvvCode = self.CVV_Tfref.text ?? ""
        self.postalCode = self.PostalCode_Tfref.text ?? ""
        indicator.showActivityIndicator()
        self.viewModel.requestForAddNewCardAPIServices(perams: ["userid":userID,"account":self.accountNumber,"exp":self.expNumber,"postal":self.postalCode,"cvv":self.cvvCode,"name":self.name]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                    self.CardName_Tfref.text = ""
                    self.cardNumber_Tfref.text = ""
                    self.Expiry_MY_Tfref.text = ""
                    self.CVV_Tfref.text = ""
                    self.PostalCode_Tfref.text = ""
                    self.AddCardView_Heaightref.constant = 0
                    self.savedCardListApiCall()
                    self.ShowAlert(message: UserData.message ?? "")
                    } else {
                       self.savedCardListApiCall()
                       self.ShowAlert(message: UserData.message ?? "Something went wrong.")
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
extension AvilableCardsViewController {
    //MARK: - Api Intigration
    func savedCardListApiCall(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForsavedCardListAPIServices(perams: ["userid":"701"]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.array_AvailableCardList = UserData
                    if let userData = UserData.data as? [SecondBookingDatar] {
                        self.array_AvailableCardListr = userData
                    }
                    self.tableview_SavedCardsRef.reloadData()
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

extension AvilableCardsViewController {
    //MARK: - Api Intigration
    func removeCardListApiCall(card_id: String){
        let alertController = UIAlertController(title: kApptitle, message: "Are sure you want Delete this Saved Card?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "YES", style: .default) { (UIAlertAction) in
          
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForRemoveCardAPIServices(perams: ["userid":"701","card_id":card_id]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        self.array_AvailableCardListr.removeAll()
                        self.tableview_SavedCardsRef.reloadData()
                    self.savedCardListApiCall()
                    self.ShowAlert(message: UserData.message ?? "")
                } else {
                    self.savedCardListApiCall()
                    self.ShowAlert(message: UserData.message ?? "Something went wrong.")
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
        let cancel = UIAlertAction(title: "NO", style: .default) { (UIAlertAction) in
        }
        alertController.addAction(OKAction)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AvilableCardsViewController: UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array_AvailableCardListr.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:SavedCardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SavedCardsTableViewCell", for: indexPath) as? SavedCardsTableViewCell else {return UITableViewCell()}
        let cardNumber = self.array_AvailableCardListr[indexPath.row].token ?? ""
        var showCardNumb = String(cardNumber.suffix(4))
        if cardNumber.count >=  4 {
            showCardNumb = String(cardNumber.suffix(4))
        }
        let ExpiryDate = self.array_AvailableCardListr[indexPath.row].expiry ?? ""
        let yearStr = ExpiryDate.suffix(2)
        let monthStr = ExpiryDate.prefix(2)

        cell.lbl_CardNumberRef.text = "XXXXXXXXXXXX" + showCardNumb
        cell.lbl_ExpiryYearRef.text = "Expiry year : " + yearStr
        cell.lbl_ExpiryMonthRef.text = "Expiry month : " + monthStr
        
        cell.view_BackgroundRef.layer.cornerRadius = 5.0
        cell.view_BackgroundRef.layer.masksToBounds = true
        cell.selectionStyle = .none
        cell.btn_DeleteRef.tag = indexPath.row
        cell.btn_DeleteRef.addTarget(self, action: #selector(btnRemovecard), for: .touchUpInside)
        return cell
    }
    
    @objc func btnRemovecard(sender: UIButton){
        if let cardid = self.array_AvailableCardListr[sender.tag].acctid as? String {
            self.removeCardListApiCall(card_id: cardid)
        }
    }
    
}
extension AvilableCardsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
   

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
        self.expNumber = self.expMonth + "/" + self.expYear
        self.Expiry_MY_Tfref.text =  self.expMonth + " / " + self.expYear
    }
}
