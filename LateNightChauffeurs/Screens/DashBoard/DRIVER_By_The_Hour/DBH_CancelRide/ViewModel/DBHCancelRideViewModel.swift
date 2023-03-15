//
//  DBHCancelRideViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 15/03/23.
//

import Foundation

class DBHCancelRideViewModel: NSObject {
    
    private var CancelRideServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.CancelRideServices = ApiService
    }
    
    func requestForcancelDBHRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        CancelRideServices.requestForCancelDBHRideServices(perams) { success, model, error in
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
    
    func requestForCancelDBHRideAmountAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideAmountData?, String?) -> ()) {
        CancelRideServices.requestForCancelDBHRideAmountServices(perams) { success, model, error in
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


