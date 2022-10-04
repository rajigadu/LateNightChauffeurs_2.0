//
//  ForgotPasswordViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

class ForgotPasswordViewModel: NSObject {
    
    private var ForgotPasswordServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.ForgotPasswordServices = ApiService
    }
    //MARK: - Forgot Password Api Intigraation
    func requestForForgotPasswordServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ForgotPasswordUserData?, String?) -> ()) {
        ForgotPasswordServices.requestForForgotPasswordServices(perams) { success, model, error in
            if success, let ForgotPasswordUserData = model {
                if ForgotPasswordUserData.loginStatus == "1" {
                    completion(true, ForgotPasswordUserData, nil)
                } else {
                    completion(false, nil, ForgotPasswordUserData.userData?[0].Message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
