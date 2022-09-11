//
//  ChangePasswordUserData.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import Foundation

typealias ChangePasswordUserData = ChangePasswordUserDetails

struct ChangePasswordUserDetails : Codable {
    let userData : [ChangePasswordUserDatar]?
    let loginStatus : String?

    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([ChangePasswordUserDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
    }
}

struct ChangePasswordUserDatar : Codable {
    let Message : String?

    enum CodingKeys: String, CodingKey {

        case Message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
    }

}
