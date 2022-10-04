//
//  ForgotPasswordViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var txt_UserMailRef: UITextField!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        ForgotPasswordViewModel()
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Class Actions
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        forgotPasswordApiCall()
    }
}
extension ForgotPasswordViewController {
    //MARK: - Api Intigration
    //MARK: - Forgot Password Api Intigraation
    func forgotPasswordApiCall(){
        guard let userEmail = txt_UserMailRef.text else {return}
        if userEmail.isEmpty || !isValidEmail(userEmail) {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            indicator.showActivityIndicator()
            self.viewModel.requestForForgotPasswordServices(perams: ["email":userEmail]) { success, model, error in
                if success, let ForgotPasswordUserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.ShowAlertWithPop(message: ForgotPasswordUserData.userData?[0].Message ?? "password sent to your email address.")
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                    }
                }
            }
        }
    }
}
