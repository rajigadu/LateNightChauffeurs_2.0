//
//  NotificationViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import Foundation
class NotificationViewModel: NSObject {
    
    private var NotificationServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.NotificationServices = ApiService
    }
    
    func requestForNotificationAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, NotificationData?, String?) -> ()) {
        NotificationServices.requestForNotificationServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "Something went wrong")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
}


