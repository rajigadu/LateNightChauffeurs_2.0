//
//  CancelBookingViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import Foundation

class CancelBookingViewModel: NSObject {
    
    private var CancelBookingServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.CancelBookingServices = ApiService
    }
    
//    func requestForGetCancelInfoServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ForgotPasswordUserData?, String?) -> ()) {
//        CancelBookingServices.requestForGetCancelInfoServices(perams) { success, model, error in
//            if success, let ForgotPasswordUserData = model {
//                if ForgotPasswordUserData.loginStatus == "1" {
//                    completion(true, ForgotPasswordUserData, nil)
//                } else {
//                    completion(false, nil, ForgotPasswordUserData.userData?[0].Message)
//                }
//            } else {
//                completion(false, nil, error)
//            }
//        }
    // }
}
