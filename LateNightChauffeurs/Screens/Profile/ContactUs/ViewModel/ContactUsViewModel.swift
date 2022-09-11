//
//  ContactUsViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import Foundation

class ContactUsViewModel: NSObject {
    
    private var ContactUsServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.ContactUsServices = ApiService
    }
    
    func requestForContactUsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ContactUsUserData?, String?) -> ()) {
        ContactUsServices.requestForContactUsServices(perams) { success, model, error in
            if success, let ContactUsUserData = model {
                if ContactUsUserData.loginStatus == "1" {
                    completion(true, ContactUsUserData, nil)
                } else {
                    completion(false, nil, ContactUsUserData.userData?[0].Message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
