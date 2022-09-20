//
//  StopsViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import UIKit
import GooglePlaces
protocol AddedStops {
    func AddedStops(stopsList: [String])
}

class StopsViewController: UIViewController {
    
    @IBOutlet weak var tableview_StopshistoryRef: UITableView!
    @IBOutlet weak var txt_StoplocationRef: UITextField!
    @IBOutlet weak var addAddressToTFBtn: UIButton!
    @IBOutlet weak var btn_AddStopAddressRef: UIButton!
    @IBOutlet weak var btn_SubmitActionRef: UIButton!
    @IBOutlet weak var btn_SubmitHeghtConstraintRef: NSLayoutConstraint!
    
    var addedStops:[String] = []
    var dalegate:AddedStops?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_AddStopAddressActionRef(_ sender: Any){
        guard let stopAddress = txt_StoplocationRef.text else{return}
        if stopAddress != "" {
        self.addedStops.append(stopAddress)
        self.txt_StoplocationRef.text = ""
        self.tableview_StopshistoryRef.reloadData()
        }
    }
    
    @IBAction func btn_SubmitActionRef(_ sender: Any){
        dalegate?.AddedStops(stopsList: addedStops)
        popToBackVC()
    }
    
    @IBAction func btn_selecteTheAddressRef(_ sender: Any){
        let acController = GMSAutocompleteViewController()
        
        let searchBarTextAttributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white, NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        
        acController.delegate = self
        acController.modalPresentationStyle = .fullScreen
         present(acController, animated: true, completion: nil)

    }
    
}

extension StopsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView,ArrayCount : addedStops.count,numberOfsections : 1,data_MSG_Str : "No stop address found.")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StopsTableViewCell", for: indexPath) as? StopsTableViewCell else {return UITableViewCell()}
        cell.lbl_StoplocationRef.text = addedStops[indexPath.row]
        cell.btn_DeleteRef.tag = indexPath.row
        cell.btn_DeleteRef.addTarget(self, action: #selector(btnDeletePress), for: .touchUpInside)
        return cell
    }
    
    @objc func btnDeletePress(sender: UIButton) {
        if addedStops.count > 0 {
            if sender.tag <= addedStops.count {
                addedStops.remove(at: sender.tag)
            }
        }
        self.tableview_StopshistoryRef.reloadData()
        return
    }
    
}
//PickUp Location and Drop location setUP
extension StopsViewController: GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        //  self.addressID = place.placeID
        self.txt_StoplocationRef.text = place.formattedAddress
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
