//
//  LoginViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

class LoginViewModel: NSObject {
    
    private var LoginedServices: LateNightChauffeursUSERServiceProtocol
        
    init(LoginedService: LateNightChauffeursUSERServiceProtocol = LoginedService()) {
        self.LoginedServices = LoginedService
    }
    
    func getUserDetails(perams: Dictionary<String,String>, completion: @escaping (Bool, UserData?, String?) -> ()) {
        LoginedServices.getLoginedUserDetails(perams) { success, model, error in
            if success, let LoginedUser = model {
                completion(true, LoginedUser, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
