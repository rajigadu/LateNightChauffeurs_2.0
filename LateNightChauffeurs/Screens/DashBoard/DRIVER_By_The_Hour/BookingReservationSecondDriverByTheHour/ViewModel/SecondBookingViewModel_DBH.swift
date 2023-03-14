//
//  SecondBookingViewModel_DBH.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 12/03/23.
//

import Foundation
import UIKit

class SecondBookingViewModel_DBH: NSObject {
    
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
        SecondBookingServices.requestForDBHGetvalidatepromocodeServices(perams) { success, model, error in
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
               
                    completion(true, UserData, nil)
              
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForcreateNewRideAPIServices(perams: Dictionary<String,Any>, completion: @escaping (Bool, createNewRideData?, String?) -> ()) {
        SecondBookingServices.requestForCreateDBH_NewRideAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForEditRideAPIServices(perams: Dictionary<String,Any>, completion: @escaping (Bool, createNewRideData?, String?) -> ()) {
        SecondBookingServices.requestForEditDBHRideAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}