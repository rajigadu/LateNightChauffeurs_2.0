//
//  BookingReservationViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import UIKit
import GooglePlaces

class BookingReservationViewController: UIViewController, SKUIDatePickerDelegate, SKUITimePickerDelegate {
    
    @IBOutlet weak var tableview_StoplistRef: UITableView!
    @IBOutlet weak var txt_PickUpLocationRef: UITextField!
    @IBOutlet weak var txt_DropLocationRef: UITextField!
    @IBOutlet weak var textview_Descriptionref: UITextView!
    
    @IBOutlet weak var lbl_DescriptionRef: UILabel!
    @IBOutlet weak var lbl_CardNumberRef: UILabel!
    @IBOutlet weak var lbl_CardExpiryMonthRef: UILabel!
    @IBOutlet weak var lbl_CardExpiryYearRef: UILabel!
    @IBOutlet weak var lbl_NoPaymentCardDetailsRef: UILabel!
    
    @IBOutlet weak var view_PaymentCardDetailsRef: UIView!
    @IBOutlet weak var view_CustomviewBookingTimeRef: UIView!
    
    @IBOutlet weak var txt_ChooseBookingTypeRef: UITextField!
    @IBOutlet weak var txt_FutureBookingDateRef: UITextField!
    @IBOutlet weak var txt_FutureBookingTimeRef: UITextField!
    
    @IBOutlet weak var view_FutureBookingConstraintRef:NSLayoutConstraint!
    @IBOutlet weak var view_PaymentCardDetailsConstraintRef:NSLayoutConstraint!
    
    @IBOutlet weak var SecondScreenEsibookviewref: UIView!
    @IBOutlet weak var ChooseCard_btn_ref: UIButton!
    @IBOutlet weak var carManualViewref: UIView!
    @IBOutlet weak var carddetailsview_ref: UIView!
    @IBOutlet weak var bookingridedetailsview_ref: UIView!
    
    @IBOutlet weak var AddCardetailsbtn_ref: UIButton!
    @IBOutlet weak var booknowview_ref: UIView!
    @IBOutlet weak var removecarddetailsbtn_ref: UIButton!
    
    //promocode
    @IBOutlet weak var promocodetf_ref: UITextField!
    @IBOutlet weak var promocodebtn_ref: UIButton!
    @IBOutlet weak var PromoCodeMainbtnref: UIButton!
    
    
    @IBOutlet weak var btn_CheckTransmissionRef: UIButton!
    @IBOutlet weak var btn_BookingNowRef: UIButton!
    
    var dict_SelectedRideDetailsForEdit = Dictionary<String,Any>()
    var str_ComingFrom = ""
    // var locationManager = CLLocationManager()
    
    //var locationManager: CLLocationManager?
//    var bookingReservationModel: BookingModel =  BookingModel()
    
    
    //date Picker
    lazy var viewModel = {
        BookingReservationViewModel()
    }()
    
    //step - 1 - Picker Step
    private var skUIdatePicker:SKUIDatePicker?
    var skUItimePicker:SKUITimePicker?
    //step - 2 - Picker and drop location setup
    var selctingPickLocation = ""
    var selctingDropLocation = ""
    //step - 3 - Transmission
    var isTransmission = false
    //step - 4 - Add Stops
    var ary_StopList:[String] = []
    //step - 5 - Estimate price
    var userPickUplatitudeStr = String()
    var userPickUplongitudeStr = String()
    var userDroplatitudeStr = String()
    var userDroplongitudeStr = String()
    var userDropCityNameStr = String()
    var userPickCityNameStr = String()
    //step - 6 - creating of global dict
    var bookingModel: BookingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IntialMethod()
        
        
        self.txt_FutureBookingDateRef.text = "09-27-2022"
        self.txt_FutureBookingTimeRef.text = "09:03 AM"
        self.txt_PickUpLocationRef.text = "Kommala Padu, Andhra Pradesh 523303, India"
        self.txt_DropLocationRef.text = "Addanki, Andhra Pradesh 523201, India"
        self.textview_Descriptionref.text = "hello sdf"
        self.userPickUplatitudeStr = "16.0294422"
        self.userPickUplongitudeStr = "79.9447885"
        self.userDroplatitudeStr = "15.810707"
        self.userDroplongitudeStr = "79.9724245"
        self.userDropCityNameStr = "Addanki"
        self.userPickCityNameStr = "Kommala Padu"
        self.ary_StopList.append("WXP4+8P2, Kopperapadu, Chinakotha Palle, Andhra Pradesh 523303, India")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func IntialMethod() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Intialise Date picker
        
        self.title = "Book Reservation"
        self.carddetailsview_ref.isHidden = true;
        self.booknowview_ref.isHidden = true;
        
        //step - 1
        skUIdatePicker = SKUIDatePicker()
        skUIdatePicker?.delegate = self
        skUIdatePicker?.showDatePicker(txtDatePicker:txt_FutureBookingDateRef)
        
        //step - 3
        self.btn_CheckTransmissionRef.setImage(UIImage(named: "checkbox_unchecked"), for: .normal)

     }
    
    //MARK: - UIButton Actions
    @IBAction func btn_AddStopAddressActionRef(_ sender:Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "StopsViewController") as! StopsViewController
        nxtVC.dalegate = self
        nxtVC.addedStops = self.ary_StopList
         self.navigationController?.pushViewController(nxtVC, animated: true)
//        self.movetonextvc(id: "StopsViewController", storyBordid: "DashBoard", animated: true)
    }
    
    @IBAction func btn_EstimatedPriceRef(_ sender:Any) {
        self.ApiCallestimatePrice()
    }
    
    @IBAction func btn_BookingNowref(_ sender :Any) {
        
    }
    
    @IBAction func btn_SelectActiveCardActionRef(_ sender: Any) {
        
    }
    
    @IBAction func btn_CheckTransmissionActionRef(_ sender: Any) {
        if !isTransmission {
            isTransmission = true
            self.btn_CheckTransmissionRef.setImage(UIImage(named: "checkbox_checked"), for: .normal)
        } else {
            isTransmission = false
            self.btn_CheckTransmissionRef.setImage(UIImage(named: "checkbox_unchecked"), for: .normal)
        }
    }
    
    @IBAction func AddCarddetails_viewhidebtn(_ sender: Any) {
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        guard let str_Date = self.txt_FutureBookingDateRef.text else{return}
        guard let str_Time = self.txt_FutureBookingTimeRef.text else{return}
        guard let str_pickUpLocation = self.txt_PickUpLocationRef.text else {return}
        guard let str_DropLocation = self.txt_DropLocationRef.text else {return}
        guard let BookNotes = self.textview_Descriptionref.text else {return}
        var transMission = isTransmission ? "manual" : "automatic"
        bookingModel = BookingModel(userid: userID, card_id: "", acctid: "", nstops: "\(self.ary_StopList.count)", savedrop: self.ary_StopList, platitude: userPickUplatitudeStr, plongitude: userPickUplongitudeStr, pickup_address: str_pickUpLocation, pickup_city: userPickCityNameStr, drop_address: str_DropLocation, dlatitude: userDroplatitudeStr, dlongitude: userDroplongitudeStr, drop_city: userDropCityNameStr, notes: BookNotes, booking_type: "2", date: str_Date, time: str_Time, transmission: transMission, promo: "", version: "Yes")

        
        let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "SecondBookingViewController") as! SecondBookingViewController
          nxtVC.bookingModel = self.bookingModel
        self.navigationController?.pushViewController(nxtVC, animated: true)
       // self.movetonextvc(id: "SecondBookingViewController", storyBordid: "DashBoard", animated: true)
    }
    
    @IBAction func PromoMainButtjon(_ sender: Any) {
        
    }
    
    @IBAction func PromocodeBtn(_ sender: Any){
        
    }
    
    @IBAction func removecarddetailsbtn_ref(_ sender: Any) {
        
    }
    
    @IBAction func pickUpLocationBtn_ref(_ sender: Any) {
        selctingPickLocation = "yes"
        let acController = GMSAutocompleteViewController()
        
        let searchBarTextAttributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white, NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        
        acController.delegate = self
        acController.modalPresentationStyle = .fullScreen
        acController.tintColor = .white
        present(acController, animated: true, completion: nil)
     }
    
    @IBAction func dropLocationBtn_ref(_ sender: Any) {
        selctingDropLocation = "yes"
        let acController = GMSAutocompleteViewController()
        
        let searchBarTextAttributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white, NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        
        acController.delegate = self
        acController.modalPresentationStyle = .fullScreen
        acController.tintColor = .white
        present(acController, animated: true, completion: nil)
    }

}
extension BookingReservationViewController {
    
}

extension BookingReservationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_StopList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StopsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StopsListTableViewCell", for: indexPath) as! StopsListTableViewCell
        cell.lbl_StopNameRef.text = ary_StopList[indexPath.row]
        return cell
    }
}

// Date picker
extension BookingReservationViewController  {
    
    func getDate(_ sKUIDatePicker: SKUIDatePicker, date: String, SelectedDate: Date) {
        print(date)
        self.txt_FutureBookingDateRef.text = date
        self.self.txt_FutureBookingTimeRef.text = ""
        skUItimePicker = nil
        skUItimePicker = SKUITimePicker()
        skUItimePicker?.delegate = self
        skUItimePicker?.showTimePicker(txtTimePicker:txt_FutureBookingTimeRef, selectedDate: SelectedDate)
        self.view.endEditing(true)
    }
    
    func cancel(_ sKUIDatePicker:SKUIDatePicker){
        self.view.endEditing(true)
    }
}

// Time picker
extension BookingReservationViewController  {
    
    func getTime(_ sKUIDatePicker: SKUITimePicker, time: String) {
        print(time)
        self.txt_FutureBookingTimeRef.text = time
        self.view.endEditing(true)
    }
    
    func cancel(_ sKUIDatePicker:SKUITimePicker){
        self.view.endEditing(true)
    }
}

//PickUp Location and Drop location setUP
extension BookingReservationViewController: GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
      //  self.addressID = place.placeID
        if selctingDropLocation == "yes" {
            self.txt_DropLocationRef.text = place.formattedAddress
            self.userDroplatitudeStr = "\(place.coordinate.latitude)"
            self.userDroplongitudeStr = "\(place.coordinate.longitude)"
            self.userDropCityNameStr = place.name ?? ""
        } else {
            self.txt_PickUpLocationRef.text = place.formattedAddress
            self.userPickUplatitudeStr = "\(place.coordinate.latitude)"
            self.userPickUplongitudeStr = "\(place.coordinate.longitude)"
            self.userPickCityNameStr = place.name ?? ""

        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
    
}

//Stops Adding
extension BookingReservationViewController: AddedStops{
    func AddedStops(stopsList: [String]) {
        self.ary_StopList = stopsList
        self.tableview_StoplistRef.reloadData()
    }
}

//MARK: - Call Api Estimate Price
extension BookingReservationViewController {
    
    func ApiCallestimatePrice() {
        guard let str_Date = self.txt_FutureBookingDateRef.text else{return}
        guard let str_Time = self.txt_FutureBookingTimeRef.text else{return}
        guard let str_pickUpLocation = self.txt_PickUpLocationRef.text else {return}
        guard let str_DropLocation = self.txt_DropLocationRef.text else {return}
       // guard let str_promocode = self.promocodetf_ref.text else {return}
                                
         if str_Date.isEmpty {
             self.ShowAlert(message: "Please select date for booking reservation")
        } else if str_Time.isEmpty {
            self.ShowAlert(message: "Please select time for booking reservation")
        } else if str_pickUpLocation.isEmpty || userPickUplatitudeStr.isEmpty || userPickUplongitudeStr.isEmpty {
            self.ShowAlert(message: "Please select pickup for booking reservation")
         } else if str_DropLocation.isEmpty || userDroplatitudeStr.isEmpty || userDroplongitudeStr.isEmpty {
             self.ShowAlert(message: "Please select drop for booking reservation")
         } else {
            indicator.showActivityIndicator()
             self.viewModel.requestForEstimatePriceForBookingServices(perams: ["pick_Add":str_pickUpLocation,"Drop_Add":str_DropLocation,"pick_lat":self.userPickUplatitudeStr,"pick_lng":self.userPickUplongitudeStr,"dest_lat":self.userDroplatitudeStr,"dest_lng":self.userDroplongitudeStr,"promo": self.promocodetf_ref.text ?? "","count":"\(self.ary_StopList.count )" , "date":str_Date,"time":str_Time,]) { success, model, error in
                if success, let UserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        
                        let str_EstimationPriceDetails = "\n\nPrice Details : \n\n Distance:  \(UserData.data?[0].distance ?? "") \n Time:  \(UserData.data?[0].estimate_time ?? "") \n Price:  \(UserData.data?[0].estimate_price ?? "")"
                        self.ShowAlert(message: str_EstimationPriceDetails)
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
}