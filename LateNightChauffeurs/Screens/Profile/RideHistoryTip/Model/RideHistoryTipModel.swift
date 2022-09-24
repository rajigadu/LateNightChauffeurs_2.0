//
//  RideHistoryTipModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import Foundation

typealias RideHistoryTipData = RideHistoryTipModel

struct RideHistoryTipModel : Codable {
    let userData : [RideHistoryTipDatar]?
    let loginStatus : String?

    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([RideHistoryTipDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
    }
}

struct RideHistoryTipDatar : Codable {
    let Message : String?

    enum CodingKeys: String, CodingKey {

        case Message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
    }

}
