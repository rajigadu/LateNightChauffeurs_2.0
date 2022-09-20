//
//  BookingReservationViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import Foundation

class BookingReservationViewModel: NSObject {
    
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
