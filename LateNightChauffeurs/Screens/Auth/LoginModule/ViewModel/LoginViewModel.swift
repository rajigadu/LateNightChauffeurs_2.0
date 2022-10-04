//
//  LoginViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

class LoginViewModel: NSObject {
    
    private var LoginedServices: LateNightChauffeursUSERServiceProtocol
    
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.LoginedServices = ApiService
    }
    //MARK: --  Login Api Intigration...
    func getUserDetails(perams: Dictionary<String,String>, completion: @escaping (Bool, UserData?, String?) -> ()) {
        LoginedServices.getLoginedUserDetails(perams) { success, model, error in
            if success, let LoginedUser = model {
                if LoginedUser.loginStatus == "1" {
                UserDefaults.standard.set(LoginedUser.userDetails?[0].userId, forKey: "UserLoginID")
                UserDefaults.standard.set(LoginedUser.userDetails?[0].emailAddress, forKey: "UserEmailID")
                UserDefaults.standard.set(LoginedUser.userDetails?[0].firstName, forKey: "UserFirstName")
                UserDefaults.standard.set(LoginedUser.userDetails?[0].lastName, forKey: "UserLastName")
                UserDefaults.standard.set(LoginedUser.userDetails?[0].mobileNumber, forKey: "UserMobilenumber")
                UserDefaults.standard.set(true, forKey: "IsUserLogined")
                UserDefaults.standard.set(API_URl.API_BASEIMAGE_URL + (LoginedUser.userDetails?[0].profilePic ?? ""), forKey: "userProfilepic")
                UserDefaults.standard.set("Normal Login", forKey: "userLoginType")
                UserDefaults.standard.set(LoginedUser.paymentCardStatus, forKey: "CardStatus")
                completion(true, LoginedUser, nil)
                } else {
                  completion(false, nil, LoginedUser.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
