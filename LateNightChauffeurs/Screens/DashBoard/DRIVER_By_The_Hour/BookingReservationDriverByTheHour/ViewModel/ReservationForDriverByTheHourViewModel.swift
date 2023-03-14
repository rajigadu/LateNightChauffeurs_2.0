//
//  ReservationForDriverByTheHourViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 10/03/23.
//

import Foundation

class ReservationForDriverByTheHourViewModel : NSObject {
    
    private var BookingReservationServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.BookingReservationServices = ApiService
    }
    
    func requestForEstimatePriceForBookingServices(perams: Dictionary<String,String>, completion: @escaping (Bool, EstinatePriceModelData?, String?) -> ()) {
        BookingReservationServices.requestForGetEstimatePriceServices(perams) { success, model, error in
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
