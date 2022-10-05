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
    @IBOutlet weak var lbl_FutureRideTimeCheck: UILabel!
    @IBOutlet weak var lbl_FutureRideCheckConstraint: NSLayoutConstraint!
    //MARK: - Class Propeties
   // var locationManager = CLLocationManager()
    let didFindMyLocation = false
var bannersCount = 0
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupSideMenu()
       // self.swipeRight()
        initializeTheLocationManager()
        //self.mapView.isMyLocationEnabled = true
    }

    
    //MARK: - Class Actions
    
    @IBAction func setupSideMenu(_ sender : Any){
        self.navigateToSideMenu()
    }
    
    @IBAction func bookingReservation(_ sender: Any) {
        self.movetonextvc(id: "BookingReservationViewController", storyBordid: "DashBoard", animated: true)
    }
    
    @IBAction func MovetoAlertNotification(_ sender: Any) {
        self.movetonextvc(id: "NotificationViewController", storyBordid: "Profile", animated: true)
    }
 
    func initializeTheLocationManager() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
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
