//
//  LoginViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IBOutLets
    @IBOutlet weak var txt_PasswordRef: UITextField!
    @IBOutlet weak var txt_UserMailRef: UITextField!
    @IBOutlet weak var btn_LoginRef: UIButton!
    
    //MARK: - Properties
    lazy var viewModel = {
        LoginViewModel()
    }()
    
    //MARK: - Life Cycle Start
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_PasswordRef.text = "123"
        self.txt_UserMailRef.text = "rajesh@anaad.net"
        // Do any additional setup after loading the view.
    }
    
    //MARK: - UI-Button Actions
    
    @IBAction func signINButton(_ sender: Any) {
        self.LoginApiCall()
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        self.movetonextvc(id: "ForgotPasswordViewController", storyBordid: "Authentication")
    }
    
    @IBAction func signUPButton(_ sender: Any) {
        self.movetonextvc(id: "RegistrationViewController", storyBordid: "Authentication")
    }
    
}
extension LoginViewController {
    
    func LoginApiCall(){
        guard let userEmail = txt_UserMailRef.text else {return}
        guard let userPassword = txt_PasswordRef.text else {return}
        if userEmail.isEmpty || !isValidEmail(userEmail) || userPassword.isEmpty {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
           
                indicator.showActivityIndicator()
                self.viewModel.getUserDetails(perams: ["emailid":userEmail,"password":userPassword]) { success, model, error in
                    if success, let LoginedUser = model {
                        DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        UserDefaults.standard.set(LoginedUser.data?[0].id, forKey: "UserLoginID")
                        UserDefaults.standard.set(LoginedUser.data?[0].email_address, forKey: "UserEmailID")
                        UserDefaults.standard.set(LoginedUser.data?[0].first_name, forKey: "UserFirstName")
                        UserDefaults.standard.set(LoginedUser.data?[0].last_name, forKey: "UserLastName")
                            UserDefaults.standard.set(LoginedUser.data?[0].mobile, forKey: "UserMobilenumber")
                            UserDefaults.standard.set(API_URl.API_BASEIMAGE_URL + (LoginedUser.data?[0].profile_pic ?? ""), forKey: "userProfilepic")
                        UserDefaults.standard.set("Normal Login", forKey: "userLoginType")
                        UserDefaults.standard.set(LoginedUser.card_status, forKey: "CardStatus")
                        
                        self.showToast(message: LoginedUser.msg ?? "Welcome! You are successfully login in your account panel.", font: .systemFont(ofSize: 12.0))
                        }
                    } else {
                        DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.showToast(message: error ?? "Invalid email or password.", font: .systemFont(ofSize: 12.0))
                        }
                    }
            }
        }
    }
    
}
