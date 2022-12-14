//
//  ProfileViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Class outlets
    @IBOutlet weak var txt_FirstNameRef: UITextField!
    @IBOutlet weak var txt_LastNameRef: UITextField!
    @IBOutlet weak var btn_UploadProfilepicRef: UIButton!
    @IBOutlet weak var imageview_ProfilepicRef: UIImageView!
    @IBOutlet weak var txt_MobilenumberRef: UITextField!
    @IBOutlet weak var btn_UpdateRef: UIButton!
    
    //MARK: - Class Propeties
    var profilePic = UIImage()
    var isProfilePicTaken = false
    lazy var viewModel = {
        ProfileViewModel()
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //First Name
        if let Str_FirstName = UserDefaults.standard.string(forKey: "UserFirstName") as? String {
            self.txt_FirstNameRef.text = Str_FirstName
        }
        //Last Name
        if let Str_LastName = UserDefaults.standard.string(forKey: "UserLastName") as? String {
            self.txt_LastNameRef.text = Str_LastName
         }
        //Mobile Number
        if let Str_Mobilenumber = UserDefaults.standard.string(forKey: "UserMobilenumber") as? String {
            self.txt_MobilenumberRef.text = Str_Mobilenumber
         }
        //User Image
        if let Str_UserImage = UserDefaults.standard.string(forKey: "userProfilepic") as? String {
            self.imageview_ProfilepicRef.sd_setImage(with: URL(string: API_URl.API_BASEIMAGE_URL +  Str_UserImage), placeholderImage: UIImage(named: "UserPic"))
         }
    }
    
    //MARK: - Class Actions
    @IBAction func btn_UploadProfilepicRef(_ sender: Any) {
        isProfilePicTaken = false
        ImagePickerManager().pickImage(self){ image in
                //here is the image
            self.imageview_ProfilepicRef.image = image
            self.profilePic = image
            self.isProfilePicTaken = true
             
            }
    }
    
    @IBAction func btn_UpdateRef(_ sender: Any) {
        self.EditProfileApiCall()
    }
}
extension ProfileViewController {
    
    //MARK: - Api Intigration
    func EditProfileApiCall(){
        guard let str_FirstName = txt_FirstNameRef.text else {return}
        guard let str_LastName = txt_LastNameRef.text else {return}
        guard let str_mobileNumber = txt_MobilenumberRef.text else {return}
        guard let str_userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}

        if str_FirstName.isEmpty || str_LastName.isEmpty || str_mobileNumber.isEmpty || str_userID.isEmpty || !isProfilePicTaken {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            indicator.showActivityIndicator()
            self.viewModel.requestForEditProfileServices(perams: ["userid":str_userID,"fname":str_FirstName,"lname":str_LastName,"mobile":str_mobileNumber], picImage: self.profilePic, fileName: "profile_pic") { success, model, error in
                if success, let ForgotPasswordUserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.ShowAlertWithPop(message: ForgotPasswordUserData.message ?? "Profile updated  successfully.")
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
