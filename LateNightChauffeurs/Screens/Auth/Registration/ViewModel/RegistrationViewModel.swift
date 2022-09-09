//
//  RegistrationViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

class RegistrationViewModel: NSObject {
    
    private var RegistrationServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.RegistrationServices = ApiService
    }
    
    func requestForRegistrationServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RegistrationUserData?, String?) -> ()) {
        RegistrationServices.requestForRegistrationServices(perams) { success, model, error in
            if success, let RegistrationUserData = model {
                if RegistrationUserData.loginStatus == "1" {
                    completion(true, RegistrationUserData, nil)
                } else {
                    completion(false, nil, RegistrationUserData.userData?[0].Message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
