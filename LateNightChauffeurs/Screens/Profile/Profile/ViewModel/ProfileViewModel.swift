//
//  ProfileViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import Foundation
import UIKit

class ProfileViewModel: NSObject {
    
    private var ProfileServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.ProfileServices = ApiService
    }
    
    func requestForEditProfileServices(perams: Dictionary<String,String>, picImage: UIImage, fileName: String, profileStruct : uploadImage, completion: @escaping (Bool, ProfileUserData?, String?) -> ()) {
        ProfileServices.requestForEditProfileServices(perams, picImage: picImage, fileName: fileName, profileStruct: profileStruct) { success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.loginStatus == "1" {
                    UserDefaults.standard.set(EditProfileUserData.userData?[0].FName, forKey: "UserFirstName")
                    UserDefaults.standard.set(EditProfileUserData.userData?[0].LName, forKey: "UserLastName")
                    UserDefaults.standard.set(EditProfileUserData.userData?[0].MobileNumber, forKey: "UserMobilenumber")
                    UserDefaults.standard.set(API_URl.API_BASEIMAGE_URL + (EditProfileUserData.userData?[0].profilePic ?? ""), forKey: "userProfilepic")
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, EditProfileUserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
