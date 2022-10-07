//
//  DashBoardViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 09/09/22.
//

import UIKit
import SideMenu
import GoogleMaps

class DashBoardViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var view_BannerADSViewRef: UIView!
    @IBOutlet weak var containerViewBannerRef: UIView!
    @IBOutlet weak var btnFutureRideTimeCheck: UIButton!
    @IBOutlet weak var BookingReservationButton: UIButton!
    @IBOutlet weak var lbl_FutureRideTimeCheck: UILabel!
    @IBOutlet weak var lbl_FutureRideCheckConstraint: NSLayoutConstraint!
    @IBOutlet weak var view_BannerAdsConstraintRef: NSLayoutConstraint!
    //MARK: - Class Propeties
   // var locationManager = CLLocationManager()
    let didFindMyLocation = false
    var bannersCount = 0
    var str_UserLoginID = ""
    var ongoing_requestID = ""
    var str_AppVersion = ""
    var timer_ForGettingDriverCurrentLocationFromServer: Timer?
    var timerOngoingRide: Timer?
    var str_TodayDate = ""
    let getLocation = GetLocation()
    var currentRideData: [currentRideDatar] = []
    var str_UserCurrentLocationLatitude = ""
    var str_UserCurrentLocationLongitude = ""
    var str_UserCurrentLocationAddress = ""
    var str_UserCurrentLocationCity = ""
    lazy var viewModel = {
        DashBoardViewModel()
    }()
    var getGoogleKeyData: DashBoardUserDatar?
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupSideMenu()
       // self.swipeRight()
        initializeTheLocationManager()
        self.str_UserLoginID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
       // self.str_AppVersion = UserDefaults.standard.string(forKey: "CFBundleShortVersionString") ?? ""
        self.str_AppVersion = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String ?? ""
 
        do {
              // Set the map style by passing the URL of the local file.
              if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                  self.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
              } else {
                  NSLog("Unable to find style.json")
              }
          } catch {
              NSLog("One or more of the map styles failed to load. \(error)")
          }
        //self.mapView.isMyLocationEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ((timer_ForGettingDriverCurrentLocationFromServer?.isValid) != nil) {
            timer_ForGettingDriverCurrentLocationFromServer?.invalidate()
                timer_ForGettingDriverCurrentLocationFromServer = nil
            }
        
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        str_TodayDate = dateFormatter.string(from: todayDate)

        
        let str_RideRequestProcessing = UserDefaults.standard.string(forKey: "RideRequestProcessingCheck") ?? ""
        
        if str_RideRequestProcessing == "RideRequestProcessing" {
            //Checking  the condition..........
            ongoing_requestID = UserDefaults.standard.string(forKey: "OnGoingRequestID") ?? ""
            if ((timerOngoingRide?.isValid) != nil) {
                timerOngoingRide?.invalidate()
                timerOngoingRide = nil
                timerOngoingRide = Timer.scheduledTimer(timeInterval: 25.0, target: self, selector: #selector(onGoingRideRequestTimeFired), userInfo: nil, repeats: true)
            } else {
                timerOngoingRide = Timer.scheduledTimer(timeInterval: 25.0, target: self, selector: #selector(onGoingRideRequestTimeFired), userInfo: nil, repeats: true)
            }
            
            mapView.isHidden = false
            view_BannerADSViewRef.isHidden = false
            //view_DriverRideDetailsViewRef.hidden = true
            var str_BannersCount = UserDefaults.standard.string(forKey: "BannerCountCheck") ?? ""
            if str_BannersCount == "" {
                bannersCount = 0;
            } else {
                bannersCount = Int(str_BannersCount) ?? 0
            }
            
            if bannersCount > 0 {
                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 160.0, right: 0.0)
                self.mapView.padding = mapInsets; //UIEdgeIns
                self.view_BannerADSViewRef.isHidden = false
                self.view_BannerAdsConstraintRef.constant = 100;
            } else {
                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 70.0, right: 0.0)
                self.mapView.padding = mapInsets; //UIEdgeIns
                self.view_BannerADSViewRef.isHidden = true
                self.view_BannerAdsConstraintRef.constant = 0;
            }
        } else {
            // Current Ride API Calling..............
             self.currentRideInfoAPI()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        invalidateTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        invalidateTimer()
    }
    
    func invalidateTimer() {
        if ((timer_ForGettingDriverCurrentLocationFromServer?.isValid) != nil) {
            timer_ForGettingDriverCurrentLocationFromServer?.invalidate()
            timer_ForGettingDriverCurrentLocationFromServer = nil
        }
        if ((timerOngoingRide?.isValid) != nil) {
            timerOngoingRide?.invalidate()
            timerOngoingRide = nil
        }
    }
    //MARK: - Class Actions
    
    @IBAction func setupSideMenu(_ sender : Any){
        self.navigateToSideMenu()
       
    }
    
    @IBAction func bookingReservation(_ sender: Any) {
//        self.movetonextvc(id: "BookingReservationViewController", storyBordid: "DashBoard", animated: true)
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "BookingReservationViewController") as! BookingReservationViewController
        if str_UserCurrentLocationAddress != "" {
        nxtVC.str_UserCurrentLocationLatitude = str_UserCurrentLocationLatitude
        nxtVC.str_UserCurrentLocationLongitude = str_UserCurrentLocationLongitude
        nxtVC.str_UserCurrentLocationAddress = str_UserCurrentLocationAddress
            nxtVC.str_UserCurrentLocationCity = str_UserCurrentLocationCity
        nxtVC.str_ComingFrom = "HomePage"
    }
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    @IBAction func MovetoAlertNotification(_ sender: Any) {
        self.movetonextvc(id: "NotificationViewController", storyBordid: "Profile", animated: true)
    }
 
    func initializeTheLocationManager() {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        
        if askEnableLocationService() == "YES" {
            getLocation.run { [self] in
                if let location = $0 {
                    print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                    let CurrentLatitudeValue = location.coordinate.latitude
                    let CurrentLongitudeValue = location.coordinate.longitude
                    self.str_UserCurrentLocationLatitude = String(CurrentLatitudeValue)
                    self.str_UserCurrentLocationLongitude = String(CurrentLongitudeValue)
                  //  self.str_UserCurrentLocationAddress =  getLocation.getPlaceAddress(latitudestr: CurrentLatitudeValue, longitudestr: CurrentLongitudeValue)
                   // self.str_UserCurrentLocationCity = getLocation.getPlaceAddressCity(latitudestr: CurrentLatitudeValue, longitudestr: CurrentLongitudeValue)
                    
                    
                    
                    let location = CLLocation(latitude: CurrentLatitudeValue, longitude: CurrentLongitudeValue)
                    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                        
                        guard let placemark = placemarks?.first else {
                            let errorString = error?.localizedDescription ?? "Unexpected Error"
                            print("Unable to reverse geocode the given location. Error: \(errorString)")
                            return
                        }
                        
                        let reversedGeoLocation = ReversedGeoLocation(with: placemark)
                        print(reversedGeoLocation.formattedAddress)
                        self.str_UserCurrentLocationAddress = reversedGeoLocation.formattedAddress
                        self.str_UserCurrentLocationCity = reversedGeoLocation.city
                        
                        // Apple Inc.,
                        // 1 Infinite Loop,
                        // Cupertino, CA 95014
                        // United States
                    }
                    
                    let marker = GMSMarker()
                    let markerView = UIImageView(image: UIImage(named: "marker_green"))
                    marker.position = CLLocationCoordinate2D(latitude: CurrentLatitudeValue, longitude: CurrentLongitudeValue)
                    marker.iconView = markerView
                    marker.map = self.mapView
                    
                    let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: CurrentLatitudeValue, longitude: CurrentLongitudeValue), zoom: 12)
                   self.mapView.animate(to: camera)
                } else {
                    print("Get Location failed \(self.getLocation.didFailWithError)")
                }
            }
        }
        

    }
}
extension DashBoardViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
    
}
// MARK: - CLLocationManagerDelegate
//extension DashBoardViewController: CLLocationManagerDelegate {
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
//             mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
//         }
//     }
//}
extension DashBoardViewController {
    @IBAction func btnFutureRideTimeCheckAction(_ sender: Any) {
        
    }
}


extension DashBoardViewController {
    func showMessageForFullBanners(message : String){
        let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            if self.bannersCount <= 0 {
            } else {
                self.loadingBannerViewController()
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func loadingBannerViewController() {
        let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "BannerIDsVC") as! BannerIDsVC
        self.present(nxtVC, animated: true)
    }
}

extension DashBoardViewController {
    //MARk: -- API REQUEST CLASS DELEGATE
    //MARK: - request for Google Key
    func getgooglekeyListAPI() {
        indicator.showActivityIndicator()
        self.viewModel.requestForgetgooglekeyListAPIServices(perams: ["":""]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if UserData.status == "1" {
                        UserDefaults.standard.set(UserData.data?.key ?? "", forKey: "Googlekeyvalue")
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "no record found.", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
}

extension DashBoardViewController {
    //MARK: -- ONGOING RIDE REQUEST API
     @objc func onGoingRideRequestTimeFired() {
          indicator.showActivityIndicator()
         self.viewModel.requestForONGOINGRIDEREQUESTAPIServices(perams: ["":""]) { success, model, error in
             if success, let UserData = model {
                 DispatchQueue.main.async { [self] in
                     indicator.hideActivityIndicator()
                     if UserData.status == "1" {
                         let str_ride = UserData.data?[1].ride ?? ""
                         if str_ride == "3" {
                             if ((timerOngoingRide?.isValid) != nil) {
                                 timerOngoingRide?.invalidate()
                                 timerOngoingRide = nil
                             }
                         }
                         UserDefaults.standard.removeObject(forKey: "RideRequestProcessingCheck")
                         UserDefaults.standard.set(nil, forKey: "RideRequestProcessingCheck")
                         UserDefaults.standard.removeObject(forKey: "OnGoingRequestID")
                         UserDefaults.standard.set(nil, forKey: "OnGoingRequestID")
                         //self.btn_StartActionRef.isHidden = false
                         let str_Message = UserData.data?[0].msg ?? ""
                         self.ShowAlert(message: str_Message)
                     } else {
                         UserDefaults.standard.removeObject(forKey: "RideRequestProcessingCheck")
                         UserDefaults.standard.set(nil, forKey: "RideRequestProcessingCheck")
                         UserDefaults.standard.removeObject(forKey: "OnGoingRequestID")
                         UserDefaults.standard.set(nil, forKey: "OnGoingRequestID")
                         if ((timerOngoingRide?.isValid) != nil) {
                             timerOngoingRide?.invalidate()
                             timerOngoingRide = nil
                         }
                         //self.btn_StartActionRef.isHidden = false
                         self.currentRideInfoAPI()
                     }
                 }
             } else {
                 DispatchQueue.main.async { [self] in
                     indicator.hideActivityIndicator()
                     self.showToast(message: error ?? "no record found.", font: .systemFont(ofSize: 12.0))
                 }
             }
         }
     }
}
extension DashBoardViewController {
    //MARK: - CURRENT RIDE INFO API
    func currentRideInfoAPI() {
        //guard
            let deviceToken = "567890876"
                //UserDefaults.standard.string(forKey: "FCMDeviceToken") as? String else {return}
        indicator.showActivityIndicator()
        self.viewModel.requestForCURRENTRIDEINFOAPIServices(perams: ["userid":self.str_UserLoginID,"app_version": str_AppVersion,"devicetoken":deviceToken,"device_type":"ios"]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if ((timer_ForGettingDriverCurrentLocationFromServer?.isValid) != nil) {
                        timer_ForGettingDriverCurrentLocationFromServer?.invalidate()
                            timer_ForGettingDriverCurrentLocationFromServer = nil
                        }
                    
                    if UserData.status != "1" {
                        if let responseData = UserData.data as? [currentRideDatar] {
                            self.currentRideData = responseData
                        }
                        var str_UserAverageRating = UserData.user_rating ?? ""
                        UserDefaults.standard.set(str_UserAverageRating, forKey: "userAverageRating")
                        
                        //Banner count check for showing banners
                        var str_BannersCount = UserData.bannercount ?? ""
                        UserDefaults.standard.set(str_BannersCount, forKey: "BannerCountCheck")
                        if str_BannersCount == "" {
                            self.bannersCount = 0
                        } else {
                            self.bannersCount = Int(UserData.bannercount ?? "0") ?? 0
                        }
                        
                        //Checking next coming Future Ride Estimation Time.........
                        var str_TimeForFutureRide = UserData.time_left ?? ""
                        str_TimeForFutureRide = str_TimeForFutureRide.replacingOccurrences(of: "0 days,", with: "")
                        if bannersCount > 0 {
                            self.containerViewBannerRef.isHidden = false
                            if str_TimeForFutureRide == "" {
                                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 160.0, right: 0.0)
                                mapView.padding = mapInsets //UIEdgeIns
                                view_BannerADSViewRef.isHidden = false
                                view_BannerAdsConstraintRef.constant = 100
                                lbl_FutureRideTimeCheck.isHidden = true
                                btnFutureRideTimeCheck.isHidden = true
                                lbl_FutureRideCheckConstraint.constant = 0
                            } else {
                                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 210.0, right: 0.0)
                                mapView.padding = mapInsets //UIEdgeIns
                                lbl_FutureRideTimeCheck.text = "Your next ride starts in: \n\(str_TimeForFutureRide)"
                                self.view_BannerADSViewRef.isHidden = false
                                self.lbl_FutureRideTimeCheck.isHidden = false
                                self.btnFutureRideTimeCheck.isHidden = false
                                self.view_BannerAdsConstraintRef.constant = 150
                                self.lbl_FutureRideCheckConstraint.constant = 50;

                            }
                        } else {
                            self.containerViewBannerRef.isHidden = true
                            self.view_BannerAdsConstraintRef.constant = 50
                            if str_TimeForFutureRide == "" {
                                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 70.0, right: 0.0)
                                mapView.padding = mapInsets //UIEdgeIns
                                self.view_BannerAdsConstraintRef.constant = 0
                                self.view_BannerADSViewRef.isHidden = true
                                self.lbl_FutureRideTimeCheck.isHidden = true
                                self.btnFutureRideTimeCheck.isHidden = true
                                self.lbl_FutureRideCheckConstraint.constant = 0
                            } else {
                                let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 120.0, right: 0.0)
                                mapView.padding = mapInsets //UIEdgeIns
                                lbl_FutureRideTimeCheck.text = "Your next ride starts in: \n\(str_TimeForFutureRide)"
                                self.view_BannerADSViewRef.isHidden = false
                                self.lbl_FutureRideTimeCheck.isHidden = false
                                self.btnFutureRideTimeCheck.isHidden = false
                                self.view_BannerAdsConstraintRef.constant = 50
                                self.lbl_FutureRideCheckConstraint.constant = 50
                            }
                        }
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if ((timer_ForGettingDriverCurrentLocationFromServer?.isValid) != nil) {
                        timer_ForGettingDriverCurrentLocationFromServer?.invalidate()
                            timer_ForGettingDriverCurrentLocationFromServer = nil
                        }
                    self.showToast(message: error ?? "no record found.", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
}
