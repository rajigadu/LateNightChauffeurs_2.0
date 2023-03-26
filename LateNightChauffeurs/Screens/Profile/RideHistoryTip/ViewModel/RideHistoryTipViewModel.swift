//
//  RideHistoryTipViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import Foundation
class RideHistoryTipViewModel: NSObject {
    
    private var RideHistoryTipServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.RideHistoryTipServices = ApiService
    }
    
    func requestForSubmitFeedBackAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideHistoryTipData?, String?) -> ()) {
        RideHistoryTipServices.requestForSubmitFeedBackServices(perams) { success, model, error in
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
    
    func requestForDBHSubmitFeedBackAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideHistoryTipData?, String?) -> ()) {
        RideHistoryTipServices.requestForDBHSubmitFeedBackServices(perams) { success, model, error in
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

