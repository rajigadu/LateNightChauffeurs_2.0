//
//  DBH_RideInfoViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 14/03/23.
//

import Foundation
class DBH_RideInfoViewModel: NSObject {
    
    private var RideInfoServices: LateNightChauffeursUSERServiceProtocol
    
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.RideInfoServices = ApiService
    }
    
    func RideInfoApiService(perams: Dictionary<String,String>, completion: @escaping (Bool, DBH_RideHistoryData?, String?) -> ()) {
        RideInfoServices.requestForDBHRideInfoServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForPaymentHistoryAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, PaymentHistoryData?, String?) -> ()) {
        RideInfoServices.requestForDBHPaymentHistoryServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func PaymentSummaryApiService(perams: Dictionary<String,String>, completion: @escaping (Bool, PaymentSummaryData?, String?) -> ()) {
        RideInfoServices.requestForPaymentSummaryServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func EditRideConformationApiService(perams: Dictionary<String,String>, completion: @escaping (Bool, EditRideConfirmData?, String?) -> ()) {
        RideInfoServices.requestForEditDBHRideConformationServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }

    
}


