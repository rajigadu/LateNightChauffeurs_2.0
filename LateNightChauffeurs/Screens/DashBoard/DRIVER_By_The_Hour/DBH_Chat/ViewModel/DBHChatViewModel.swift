//
//  DBHChatViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 21/03/23.
//

import Foundation

class DBHChatViewModel: NSObject {
    
    private var DBHChatViewServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.DBHChatViewServices = ApiService
    }
    
    func requestForDBHChatViewAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, UserChatData?, String?) -> ()) {
        DBHChatViewServices.requestForDBHChatViewServices(perams) { success, model, error in
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
