//
//  ReservationForDriverByTheHourViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 10/03/23.
//

import UIKit
import GooglePlaces

class ReservationForDriverByTheHour: UIViewController, SKUIDatePickerDelegate, SKUITimePickerDelegate {
    
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
    
    var dict_SelectedRideDetailsForEdit :DBH_RideHistoryDataR?
    var str_ComingFrom = ""
    
    
    //date Picker
    lazy var viewModel = {
        ReservationForDriverByTheHourViewModel()
    }()
    
    //step - 1 - Picker Step
    private var skUIdatePicker:SKUIDatePicker?
    var skUItimePicker:SKUITimePicker?
    //step - 2 - Picker and drop location setup
    var selctingPickLocation = ""
    var selctingDropLocation = ""
    var str_UserCurrentLocationLatitude = ""
    var str_UserCurrentLocationLongitude = ""
    var str_UserCurrentLocationAddress = ""
    var str_UserCurrentLocationCity = ""
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
    var bookingModel: DBHBookingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IntialMethod()
        if str_ComingFrom == "DBHRideHistory" {
            
            self.txt_FutureBookingDateRef.text = dict_SelectedRideDetailsForEdit?.otherdate ?? ""
            self.txt_FutureBookingTimeRef.text = dict_SelectedRideDetailsForEdit?.time ?? ""
            self.txt_PickUpLocationRef.text = dict_SelectedRideDetailsForEdit?.pickup_address ?? ""
            self.textview_Descriptionref.text = dict_SelectedRideDetailsForEdit?.notes ?? ""
            self.userPickUplatitudeStr = dict_SelectedRideDetailsForEdit?.pickup_lat ?? ""
            self.userPickUplongitudeStr = dict_SelectedRideDetailsForEdit?.pickup_long ?? ""
            self.userPickCityNameStr = dict_SelectedRideDetailsForEdit?.city_pickup ?? ""
        } else  if str_ComingFrom == "HomePage" {
            self.userPickUplatitudeStr = str_UserCurrentLocationLatitude
            self.userPickUplongitudeStr = str_UserCurrentLocationLongitude
            self.userPickCityNameStr = str_UserCurrentLocationCity
            self.txt_PickUpLocationRef.text = str_UserCurrentLocationAddress
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func IntialMethod() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Intialise Date picker
        
        self.title = "Driver By The Hour"
        self.booknowview_ref.isHidden = true;
        
        //step - 1
        skUIdatePicker = SKUIDatePicker()
        skUIdatePicker?.delegate = self
        skUIdatePicker?.showDatePicker(txtDatePicker:txt_FutureBookingDateRef)
                
    }
    
    @IBAction func AddCarddetails_viewhidebtn(_ sender: Any) {
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else {return}
        guard let str_Date = self.txt_FutureBookingDateRef.text else{return}
        guard let str_Time = self.txt_FutureBookingTimeRef.text else{return}
        if str_Time == "" || str_Date == "" {
            self.ShowAlert(message: I18n.allFieldsEmpty)
        }else {
            guard let str_pickUpLocation = self.txt_PickUpLocationRef.text else {return}
            // guard let str_DropLocation = self.txt_DropLocationRef.text else {return}
            guard let BookNotes = self.textview_Descriptionref.text else {return}
            let transMission = isTransmission ? "manual" : "automatic"
            bookingModel = DBHBookingModel(userid: userID, card_id: "", acctid: "", platitude: userPickUplatitudeStr, plongitude: userPickUplongitudeStr, pickup_address: str_pickUpLocation, pickup_city: userPickCityNameStr, notes: BookNotes, booking_type: "3", date: str_Date, time: str_Time, transmission: transMission, promo: "", version: "Yes")
            
            
            let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "SecondBookingViewController_DBH") as! SecondBookingViewController_DBH
            nxtVC.bookingModel = self.bookingModel
            if self.str_ComingFrom == "DBHRideHistory" {
                nxtVC.str_ComingFrom = self.str_ComingFrom
                nxtVC.dict_SelectedRideDetailsForEdit = self.dict_SelectedRideDetailsForEdit
            }
            self.navigationController?.pushViewController(nxtVC, animated: true)
        }
        // self.movetonextvc(id: "SecondBookingViewController", storyBordid: "DashBoard", animated: true)
    }
    
    @IBAction func pickUpLocationBtn_ref(_ sender: Any) {
        selctingPickLocation = "yes"
        selctingDropLocation = "no"
        let acController = GMSAutocompleteViewController()
        
        let searchBarTextAttributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white, NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        
        acController.delegate = self
        acController.modalPresentationStyle = .fullScreen
        acController.tintColor = .white
        present(acController, animated: true, completion: nil)
    }
    
}

// Date picker
extension ReservationForDriverByTheHour  {
    
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
extension ReservationForDriverByTheHour  {
    
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
extension ReservationForDriverByTheHour: GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        //  self.addressID = place.placeID
        if selctingDropLocation == "yes" {
            //self.txt_DropLocationRef.text = place.formattedAddress
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
