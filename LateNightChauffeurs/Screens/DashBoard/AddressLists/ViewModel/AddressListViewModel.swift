//
//  AddressListViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import Foundation

class AddressListViewModel: NSObject {
    
    private var addressListServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.addressListServices = ApiService
    }
    
    func requestForgetSavedAddressListServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChangePasswordUserData?, String?) -> ()) {
        addressListServices.requestForChangePasswordServices(perams) { success, model, error in
            if success, let ChangePasswordUserData = model {
                if ChangePasswordUserData.loginStatus == "1" {
                    completion(true, ChangePasswordUserData, nil)
                } else {
                    completion(false, nil, ChangePasswordUserData.userData?[0].Message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
