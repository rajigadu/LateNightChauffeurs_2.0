//
//  RegistrationViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import UIKit
import GooglePlaces

class RegistrationViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var firstNameTxtFld: UITextField!
    @IBOutlet weak var lastNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var mobileNoTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var confrimPasswordTxtFld: UITextField!
    @IBOutlet weak var txt_AdddressRef: UITextField!
    @IBOutlet weak var btn_SignRef: UIButton!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        RegistrationViewModel()
    }()
    var addressID:String?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Class Actions
    @IBAction func registrationBtn(_ sender: Any) {
        self.registrationApiCall()
    }
    
    
    @IBAction func onLaunchClicked(_ sender: UIButton) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}
extension RegistrationViewController {
    //MARK: - Api Intigration
    func registrationApiCall(){
        guard let str_UserFirstName = firstNameTxtFld.text else {return}
        guard let str_UserLastName = lastNameTxtFld.text else {return}
        guard let str_UserEmail = emailTxtFld.text else {return}
        guard let str_UserMobilenumber = mobileNoTxtFld.text else {return}
        guard let str_Userpassword = passwordTxtFld.text else {return}
        guard let str_UserconfrimPassword = confrimPasswordTxtFld.text else {return}
        guard let str_UserAdddress = txt_AdddressRef.text else {return}
        guard let str_addressID = addressID else {return}
        
        if str_UserEmail.isEmpty || !isValidEmail(str_UserEmail) || str_UserFirstName.isEmpty || str_UserLastName.isEmpty || str_UserMobilenumber.isEmpty || str_Userpassword.isEmpty || str_UserconfrimPassword.isEmpty || str_UserAdddress.isEmpty || str_addressID.isEmpty || str_Userpassword != str_UserconfrimPassword || str_UserMobilenumber.count < 10 {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            indicator.showActivityIndicator()
            self.viewModel.requestForRegistrationServices(perams: ["fname":str_UserFirstName,"lname":str_UserLastName,"email":str_UserEmail,"mobile":str_UserMobilenumber,"password":str_Userpassword,"address":str_UserAdddress,"location_id":str_addressID]) { success, model, error in
                if success, let ForgotPasswordUserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.ShowAlertWithPop(message: ForgotPasswordUserData.userData?[0].Message ?? "password sent to your email address.")
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
extension RegistrationViewController: GMSAutocompleteViewControllerDelegate {

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
