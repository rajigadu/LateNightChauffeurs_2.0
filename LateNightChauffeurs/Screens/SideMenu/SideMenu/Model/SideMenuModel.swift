//
//  SideMenuModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import Foundation

typealias SideMenuUserData = SideMenuModel

struct SideMenuModel : Codable {
    let message : String?
    let loginStatus : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case loginStatus = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
    }
}
