//
//  DBHDriverDetailIBookingViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 15/03/23.
//

import Foundation

class DBHDriverDetailIBookingViewModel: NSObject {
    
    private var DriverDetailInFutureBookingServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.DriverDetailInFutureBookingServices = ApiService
    }
    
    func requestForDriverDetailInDBHBookingAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverDetailInFutureBookingData?, String?) -> ()) {
        DriverDetailInFutureBookingServices.requestForDriverDetailInDBHBookingServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
