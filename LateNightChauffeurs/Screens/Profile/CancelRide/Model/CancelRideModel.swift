//
//  CancelRideModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import Foundation

typealias CancelRideData = CancelRideModel

struct CancelRideModel : Codable {
    let userData : [CancelRideDatar]?
    let loginStatus : String?

    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([CancelRideDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
    }
}

struct CancelRideDatar : Codable {
    let Message : String?

    enum CodingKeys: String, CodingKey {

        case Message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
    }

}


typealias CancelRideAmountData = CancelRideAmountModel

struct CancelRideAmountModel : Codable {
    let userData : [CancelRideAmountDatar]?
    let loginStatus : String?
    let cancelAmount : String?
    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
        case cancelAmount = "amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([CancelRideAmountDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        cancelAmount = try values.decodeIfPresent(String.self, forKey: .cancelAmount)
    }
}

struct CancelRideAmountDatar : Codable {
    let Message : String?

    enum CodingKeys: String, CodingKey {

        case Message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
    }

}
