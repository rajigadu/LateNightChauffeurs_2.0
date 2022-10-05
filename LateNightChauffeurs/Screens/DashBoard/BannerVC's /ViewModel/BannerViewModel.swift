//
//  BannerViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 04/10/22.
//

import Foundation

class BannerViewModel: NSObject {
    
    private var bannerServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.bannerServices = ApiService
    }
    
    func requestForbannerServices(perams: Dictionary<String,String>, completion: @escaping (Bool, BannerData?, String?) -> ()) {
        bannerServices.requestForbannerServices(perams) { success, model, error in
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
