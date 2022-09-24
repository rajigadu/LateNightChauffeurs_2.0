//
//  StopsViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import Foundation
class StopsViewModel: NSObject {
    
    private var StopsServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.StopsServices = ApiService
    }
    
    func requestForStopsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, StopsData?, String?) -> ()) {
        StopsServices.requestForStopsServices(perams) { success, model, error in
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
