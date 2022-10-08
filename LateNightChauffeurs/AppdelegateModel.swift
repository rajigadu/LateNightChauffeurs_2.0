//
//  AppdelegateModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/10/22.
//

import Foundation

class ChatNotificationData : Codable {
    
        var message: String?
        var userid: String?
        var driver_id: String?
        var user: String?
        var ride: String?
    
    var str_RideIDr:String?
    var str_UserIDr: String?
    var str_SelectedDriverFirstNameget: String?
    var str_SelectedDriverLastNameget: String?
    var str_SelectedDriverProfilepicget: String?
    
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case message
        case userid
        case driver_id
        case user
        case ride
        
        case str_RideIDr = "rideid"
        case str_UserIDr = "driver_id_for_future_ride"
        case str_SelectedDriverFirstNameget = "first_name"
        case str_SelectedDriverLastNameget = "last_name"
        case str_SelectedDriverProfilepicget = "profile_pic"
    }

    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
               if let message = try container.decodeIfPresent(String.self, forKey: .message) {
                   self.message = message
               }
        
        if let userid = try container.decodeIfPresent(String.self, forKey: .userid) {
            self.userid = userid
        }
        if let driver_id = try container.decodeIfPresent(String.self, forKey: .driver_id) {
            self.driver_id = driver_id
        }
        if let user = try container.decodeIfPresent(String.self, forKey: .user) {
            self.user = user
        }
        if let ride = try container.decodeIfPresent(String.self, forKey: .ride) {
            self.ride = ride
        }
        
        if let str_RideIDr = try container.decodeIfPresent(String.self, forKey: .str_RideIDr) {
            self.str_RideIDr = str_RideIDr
        }
        if let str_UserIDr = try container.decodeIfPresent(String.self, forKey: .str_UserIDr) {
            self.str_UserIDr = driver_id
        }
        if let str_SelectedDriverFirstNameget = try container.decodeIfPresent(String.self, forKey: .str_SelectedDriverFirstNameget) {
            self.str_SelectedDriverFirstNameget = str_SelectedDriverFirstNameget
        }
        if let str_SelectedDriverLastNamegetride = try container.decodeIfPresent(String.self, forKey: .str_SelectedDriverLastNameget) {
            self.str_SelectedDriverLastNameget = str_SelectedDriverLastNamegetride
        }
        if let str_SelectedDriverProfilepicget = try container.decodeIfPresent(String.self, forKey: .str_SelectedDriverProfilepicget) {
            self.str_SelectedDriverProfilepicget = str_SelectedDriverProfilepicget
        }
    }
    
    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(userid, forKey: .userid)
         try container.encode(driver_id, forKey: .driver_id)
         try container.encode(user, forKey: .user)
        try container.encode(ride, forKey: .ride)
        
        try container.encode(str_RideIDr, forKey: .str_RideIDr)
        try container.encode(str_UserIDr, forKey: .str_UserIDr)
         try container.encode(str_SelectedDriverFirstNameget, forKey: .str_SelectedDriverFirstNameget)
         try container.encode(str_SelectedDriverLastNameget, forKey: .str_SelectedDriverLastNameget)
        try container.encode(str_SelectedDriverProfilepicget, forKey: .str_SelectedDriverProfilepicget)
     }
}
