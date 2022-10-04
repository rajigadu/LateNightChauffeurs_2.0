//
//  ContactUsViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var txt_UsernameRef:UITextField!
    @IBOutlet weak var txt_EmailRef: UITextField!
    @IBOutlet weak var txt_messageRef: UITextView!
    @IBOutlet weak var btn_SubmitRef: UIButton!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        ContactUsViewModel()
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Us"
        // Do any additional setup after loading the view.
    }

    //MARK: - Class Actions
    @IBAction func submitContactInfo(_ sender: Any) {
        self.contactUsApiCall()
    }
}

extension ContactUsViewController {
    
    //MARK: - Api Intigration
    func contactUsApiCall(){
        guard let str_Username = txt_UsernameRef.text else {return}
        guard let str_Email = txt_EmailRef.text else {return}
        guard let str_message = txt_messageRef.text else {return}
        guard let str_userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}

        if str_Username.isEmpty || !isValidEmail(str_Email) || str_Email.isEmpty || str_message.isEmpty || str_userID.isEmpty {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            indicator.showActivityIndicator()
            self.viewModel.requestForContactUsServices(perams: ["fullname":str_Username,"email":str_Email,"message":str_message,"userid":str_userID]) { success, model, error in
                if success, let ForgotPasswordUserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.ShowAlertWithPop(message: ForgotPasswordUserData.userData?[0].Message ?? "Thanks for contacting with us. We will get back to you as soon as possible .")
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
