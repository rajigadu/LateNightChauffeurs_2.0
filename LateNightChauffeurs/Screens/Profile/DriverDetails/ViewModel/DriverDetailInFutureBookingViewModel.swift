//
//  DriverDetailInFutureBookingViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 26/09/22.
//

import Foundation

class DriverDetailInFutureBookingViewModel: NSObject {
    
    private var DriverDetailInFutureBookingServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.DriverDetailInFutureBookingServices = ApiService
    }
    
    func requestForDriverDetailInFutureBookingAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverDetailInFutureBookingData?, String?) -> ()) {
        DriverDetailInFutureBookingServices.requestForDriverDetailInFutureBookingServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
