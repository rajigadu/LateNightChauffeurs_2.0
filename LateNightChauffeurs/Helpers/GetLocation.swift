//
//  GetLocation.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 05/10/22.
//

import Foundation
import UIKit
import CoreLocation

public class GetLocation: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var locationCallback: ((CLLocation?) -> Void)!
    var locationServicesEnabled = false
    var didFailWithError: Error?

    public func run(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled { manager.startUpdatingLocation() }
        else { locationCallback(nil) }
    }

   public func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        locationCallback(locations.last!)
        manager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        locationCallback(nil)
        manager.stopUpdatingLocation()
    }
    
    func getPlaceAddress(latitudestr: Double, longitudestr: Double)-> String {
        // Add below code to get address for touch coordinates.
        var returnAddress = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitudestr, longitude: longitudestr)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
            placemarks, error -> Void in
            
            // Place details
            guard let placeMark = placemarks?.first else { return }
            
            // Location name
            if let locationName = placeMark.location {
                print(locationName)
                //returnAddress += locationName
            }
            // Street address
            if let street = placeMark.thoroughfare {
                print(street)
                returnAddress += street
            }
            // City
            if let city = placeMark.subAdministrativeArea {
                print(city)
                returnAddress += ", " + city
            }
            // Zip code
            if let zip = placeMark.isoCountryCode {
                print(zip)
                returnAddress += ", " + zip
            }
            // Country
            if let country = placeMark.country {
                print(country)
                returnAddress += ", " + country
            }
        })
        
        return returnAddress
    }
    
    func getPlaceAddressCity(latitudestr: Double, longitudestr: Double)-> String {
        // Add below code to get address for touch coordinates.
        var returnAddress = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitudestr, longitude: longitudestr)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
            placemarks, error -> Void in
            // Place details
            guard let placeMark = placemarks?.first else { return }
            
            // City
            if let city = placeMark.subAdministrativeArea {
                print(city)
                returnAddress =  city
            }
        })
        
        return returnAddress
    }



    deinit {
        manager.stopUpdatingLocation()
    }
    
    
}
extension UIViewController {
    func askEnableLocationService() ->String {
        var showAlertSetting = false
        var showInitLocation = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .denied:
                showAlertSetting = true
                print("HH: kCLAuthorizationStatusDenied")
            case .restricted:
                showAlertSetting = true
                print("HH: kCLAuthorizationStatusRestricted")
            case .authorizedAlways:
                showInitLocation = true
                print("HH: kCLAuthorizationStatusAuthorizedAlways")
            case .authorizedWhenInUse:
                showInitLocation = true
                print("HH: kCLAuthorizationStatusAuthorizedWhenInUse")
            case .notDetermined:
                showInitLocation = true
                print("HH: kCLAuthorizationStatusNotDetermined")
            default:
                break
            }
        }else{
            showAlertSetting = true
            print("HH: locationServicesDisabled")

        }
        if showAlertSetting {
            let alertController = UIAlertController(title: kApptitle, message: "To re-enable, please go to Settings and turn on Location Service for this app.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }

            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        if showInitLocation {

            return "YES"

        }
        return "NO"

    }
}
struct ReversedGeoLocation {
    let name: String            // eg. Apple Inc.
    let streetNumber: String    // eg. 1
    let streetName: String      // eg. Infinite Loop
    let city: String            // eg. Cupertino
    let state: String           // eg. CA
    let zipCode: String         // eg. 95014
    let country: String         // eg. United States
    let isoCountryCode: String  // eg. US
    
    var formattedAddress: String {
        return """
        \(name),
        \(streetNumber) \(streetName),
        \(city), \(state) \(zipCode)
        \(country)
        """
    }
    
    // Handle optionals as needed
    init(with placemark: CLPlacemark) {
        self.name           = placemark.name ?? ""
        self.streetName     = placemark.thoroughfare ?? ""
        self.streetNumber   = placemark.subThoroughfare ?? ""
        self.city           = placemark.locality ?? ""
        self.state          = placemark.administrativeArea ?? ""
        self.zipCode        = placemark.postalCode ?? ""
        self.country        = placemark.country ?? ""
        self.isoCountryCode = placemark.isoCountryCode ?? ""
    }
}
