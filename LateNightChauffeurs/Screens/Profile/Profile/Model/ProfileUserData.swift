//
//  ProfileUserData.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import Foundation

typealias ProfileUserData = ProfileUserDetails

struct ProfileUserDetails : Codable {
    let userData : [ProfileUserDatar]?
    let loginStatus : String?
    let message : String?
    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([ProfileUserDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct ProfileUserDatar : Codable {
    let FName : String?
    let LName : String?
    let MobileNumber : String?
    let profilePic : String?
    enum CodingKeys: String, CodingKey {
        case FName = "first_name"
        case LName = "last_name"
        case MobileNumber = "mobile"
        case profilePic = "profile_pic"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        FName = try values.decodeIfPresent(String.self, forKey: .FName)
        LName = try values.decodeIfPresent(String.self, forKey: .LName)
        MobileNumber = try values.decodeIfPresent(String.self, forKey: .MobileNumber)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
    }

}

