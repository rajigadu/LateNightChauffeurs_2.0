//
//  ShowRideLocationViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import UIKit
import GoogleMaps
class ShowRideLocationViewController: UIViewController {

    @IBOutlet weak var view_FromCurrentRideRef: UIView!
    @IBOutlet weak var lbl_HistoryRideDistanceRef: UILabel!
    @IBOutlet weak var mapViewref:GMSMapView!
    
    var ridePickUPLat = ""
    var ridePickUPLong = ""
    var rideDropLat = ""
    var rideDropLong = ""
    var rideDistance = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let marker = GMSMarker()
        let markerView = UIImageView(image: UIImage(named: "markerGreen"))
        marker.position = CLLocationCoordinate2D(latitude: Double(ridePickUPLat) ?? 0.00, longitude: Double(ridePickUPLong) ?? 0.00)
        marker.iconView = markerView
        marker.map = mapViewref
        
        let marker2 = GMSMarker()
        let markerView2 = UIImageView(image: UIImage(named: "markerRed"))
        marker2.position = CLLocationCoordinate2D(latitude: Double(rideDropLat) ?? 0.00, longitude: Double(rideDropLong) ?? 0.00)
        marker2.iconView = markerView2
        marker2.map = mapViewref
    
        if let rideDoubleValue = Double(rideDistance) as? Double {
        let rideDistance  = String(format:"%.2f", rideDoubleValue)
        self.lbl_HistoryRideDistanceRef.text = "Distance: " + rideDistance + " Miles"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let camera = GMSCameraPosition.camera(withLatitude: Double(ridePickUPLat) ?? 0.00, longitude: Double(ridePickUPLong) ?? 0.00, zoom: 15.0)
        mapViewref.camera = camera

        self.mapViewref.mapType = .satellite

        self.mapViewref.settings.scrollGestures = true
        self.mapViewref.settings.rotateGestures = true
        self.mapViewref.settings.consumesGesturesInView = true
    }


}
