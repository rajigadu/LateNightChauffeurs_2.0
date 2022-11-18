//
//  AvilableCardViewMode.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 23/09/22.
//

import Foundation
class AvilableCardViewMode: NSObject {
    
    private var AvilableCardServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.AvilableCardServices = ApiService
    }
    
    func requestForsavedCardListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, SecondBookingData?, String?) -> ()) {
        AvilableCardServices.requestForGetSavedCardListServices(perams) { success, model, error in
            if success, let UserData = model {
                     completion(true, UserData, nil)
             } else {
                completion(false, nil, error)
            }
        }
    }
        
    func requestForAddNewCardAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, addNewCardData?, String?) -> ()) {
        AvilableCardServices.requestForAddNewCardServices(perams) { success, model, error in
            if success, let UserData = model {
                    completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForRemoveCardAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, addNewCardData?, String?) -> ()) {
        AvilableCardServices.requestForRemoveCardServices(perams) { success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
             } else {
                completion(false, nil, error)
            }
        }
    }
    
}

