//
//  CancelRideViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import Foundation

class CancelRideViewModel: NSObject {
    
    private var CancelRideServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.CancelRideServices = ApiService
    }
    
    func requestForcancelFutureRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        CancelRideServices.requestForCancelRideServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.loginStatus == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.userData?[0].Message ?? "Something is wrong")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForCancelRideAmountAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideAmountData?, String?) -> ()) {
        CancelRideServices.requestForCancelRideAmountServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.loginStatus == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.userData?[0].Message ?? "Something is wrong")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}


