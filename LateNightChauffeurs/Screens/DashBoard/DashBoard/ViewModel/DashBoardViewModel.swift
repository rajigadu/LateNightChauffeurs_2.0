//
//  DashBoardViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 09/09/22.
//

import Foundation
class DashBoardViewModel: NSObject {
    
    private var dashBoardServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.dashBoardServices = ApiService
    }
    
    func requestForgetgooglekeyListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DashBoardUserData?, String?) -> ()) {
        dashBoardServices.requestForgetgooglekeyListAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                     completion(true, UserData, nil)
             } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - ONGOING RIDE REQUEST API
    func requestForONGOINGRIDEREQUESTAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, OngoingRequestRideStatusData?, String?) -> ()) {
        dashBoardServices.requestForONGOINGRIDEREQUESTAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                     completion(true, UserData, nil)
             } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - CURRENT RIDE INFO API
    func requestForCURRENTRIDEINFOAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, currentRideData?, String?) -> ()) {
        dashBoardServices.requestForCURRENTRIDEINFOAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
