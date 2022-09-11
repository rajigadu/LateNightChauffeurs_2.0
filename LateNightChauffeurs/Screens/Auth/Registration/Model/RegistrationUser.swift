//
//  RegistrationUser.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

typealias RegistrationUserData = RegistrationUserDetails

struct RegistrationUserDetails : Codable {
    let userData : [RegistrationUserDatar]?
    let loginStatus : String?
    let userId : Int?

    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
        case userId = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([RegistrationUserDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }

}


struct RegistrationUserDatar : Codable {
    let Message : String?

    enum CodingKeys: String, CodingKey {

        case Message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
    }

}
