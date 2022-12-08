//
//  MenuSliderViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import Foundation

class MenuSliderViewModel: NSObject {
    
    private var MenuSliderServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.MenuSliderServices = ApiService
    }
    
    func requestForLogoutServices(perams: Dictionary<String,String>, completion: @escaping (Bool, SideMenuUserData?, String?) -> ()) {
        MenuSliderServices.requestForLogoutServices(perams) { success, model, error in
            if success, let MenuSliderUserData = model {
                if MenuSliderUserData.loginStatus == "1" {
                    completion(true, MenuSliderUserData, nil)
                } else {
                    completion(false, nil, MenuSliderUserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForDeleteAccountServices(perams: Dictionary<String,String>, completion: @escaping (Bool, SideMenuUserData?, String?) -> ()) {
        MenuSliderServices.requestForDeleteAccountServices(perams) { success, model, error in
            if success, let MenuSliderUserData = model {
                if MenuSliderUserData.loginStatus == "1" {
                    completion(true, MenuSliderUserData, nil)
                } else {
                    completion(false, nil, MenuSliderUserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
