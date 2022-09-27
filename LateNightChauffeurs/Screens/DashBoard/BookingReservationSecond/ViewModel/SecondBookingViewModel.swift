//
//  SecondBookingViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 20/09/22.
//

import Foundation

class SecondBookingViewModel: NSObject {
    
    private var SecondBookingServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.SecondBookingServices = ApiService
    }
    
    func requestForsavedCardListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, SecondBookingData?, String?) -> ()) {
        SecondBookingServices.requestForGetSavedCardListServices(perams) { success, model, error in
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
    
    func requestForpromoCodeValidationAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, PromoCodeValidationData?, String?) -> ()) {
        SecondBookingServices.requestForGetvalidatepromocodeServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, UserData, nil)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForAddNewCardAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, addNewCardData?, String?) -> ()) {
        SecondBookingServices.requestForAddNewCardServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, UserData, nil)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForcreateNewRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, createNewRideData?, String?) -> ()) {
        SecondBookingServices.requestForcreateNewRideAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}

