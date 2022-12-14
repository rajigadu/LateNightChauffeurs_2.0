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

    //MARK: - Class Propeties
    var locationManager = CLLocationManager()
    let didFindMyLocation = false

    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupSideMenu()
       // self.swipeRight()
        initializeTheLocationManager()
        self.mapView.isMyLocationEnabled = true
    }

    
    //MARK: - Class Actions
    
    @IBAction func setupSideMenu(_ sender : Any){
        self.navigateToSideMenu()
    }
    
    
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
extension DashBoardViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location?.coordinate {
         cameraMoveToLocation(toLocation: location)
        }

     }

     func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
         if toLocation != nil {
             mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
         }
     }
}
