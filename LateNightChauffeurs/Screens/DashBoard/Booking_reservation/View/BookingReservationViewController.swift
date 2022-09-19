//
//  BookingReservationViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import UIKit
//import GoogleMaps

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
    var bookingReservationModel: BookingModel =  BookingModel()
    
    
    //date Picker
    var ary_StopList = Array<Any>()
    
    //step - 1 - Picker Step
    private var skUIdatePicker:SKUIDatePicker?
    var skUItimePicker:SKUITimePicker?
    //step - 2 - Picker and drop location setup
    var selctingPickLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IntialMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func IntialMethod() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Intialise Date picker
        
        self.title = "Book Reservation"
        self.carddetailsview_ref.isHidden = true;
        self.booknowview_ref.isHidden = true;
        
        skUIdatePicker = SKUIDatePicker()
        skUIdatePicker?.delegate = self
        skUIdatePicker?.showDatePicker(txtDatePicker:txt_FutureBookingDateRef)
        
        
        
    }
    
    //MARK: - UIButton Actions
    @IBAction func btn_AddStopAddressActionRef(_ sender:Any) {
        
    }
    
    @IBAction func btn_EstimatedPriceRef(_ sender:Any) {
        
    }
    
    @IBAction func btn_BookingNowref(_ sender :Any) {
        
    }
    
    @IBAction func btn_SelectActiveCardActionRef(_ sender: Any) {
        
    }
    
    @IBAction func btn_CheckTransmissionActionRef(_ sender: Any) {
        
    }
    
    @IBAction func AddCarddetails_viewhidebtn(_ sender: Any) {
        
    }
    
    @IBAction func PromoMainButtjon(_ sender: Any) {
        
    }
    
    @IBAction func PromocodeBtn(_ sender: Any){
        
    }
    
    @IBAction func removecarddetailsbtn_ref(_ sender: Any) {
        
    }
    
    @IBAction func pickUpLocationBtn_ref(_ sender: Any) {
        selctingPickLocation = "yes"
    }
}
extension BookingReservationViewController {
    
    func locationManagerAuthentication() {
        //        locationManager.delegate = self
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.startUpdatingLocation()
    }
}
// MARK: - CLLocationManagerDelegate
//extension BookingReservationViewController: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locationManager.location?.coordinate {
//         cameraMoveToLocation(toLocation: location)
//        }
//
//     }
//
//     func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
//         if toLocation != nil {
//            // mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
//         }
//     }
//}

extension BookingReservationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_StopList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StopsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StopsListTableViewCell", for: indexPath) as! StopsListTableViewCell
        
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

//PickUp Location
extension BookingReservationViewController: GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        self.addressID = place.placeID
        self.txt_AdddressRef.text = place.formattedAddress
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
