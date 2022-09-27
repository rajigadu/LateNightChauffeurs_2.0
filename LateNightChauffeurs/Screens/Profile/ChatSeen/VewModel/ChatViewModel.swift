//
//  ChatViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import Foundation

class ChatViewModel: NSObject {
    
    private var ChatViewServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.ChatViewServices = ApiService
    }
    
    func requestForChatViewAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, UserChatData?, String?) -> ()) {
        ChatViewServices.requestForChatViewServices(perams) { success, model, error in
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


