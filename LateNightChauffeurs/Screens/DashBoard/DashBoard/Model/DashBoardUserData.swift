//
//  DashBoardUserData.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 09/09/22.
//

import Foundation

typealias DashBoardUserData = DashBoardUserModel

struct DashBoardUserModel : Codable {
    let data : DashBoardUserDatar?
    let msg : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DashBoardUserDatar.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct DashBoardUserDatar : Codable {
    let id : String?
    let key : String?
    let status : String?
    let created_date : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case key = "key"
        case status = "status"
        case created_date = "created_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_date = try values.decodeIfPresent(String.self, forKey: .created_date)
    }

}

typealias currentRideData = currentRideModel

struct currentRideModel : Codable {
    let time_left : String?
    let data : [currentRideDatar]?
    let message : String?
    let status : String?
    let bannercount : String?
    let user_rating : String?

    enum CodingKeys: String, CodingKey {

        case time_left = "time_left"
        case data = "data"
        case message = "message"
        case status = "status"
        case bannercount = "bannercount"
        case user_rating = "user_rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time_left = try values.decodeIfPresent(String.self, forKey: .time_left)
        data = try values.decodeIfPresent([currentRideDatar].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        bannercount = try values.decodeIfPresent(String.self, forKey: .bannercount)
        user_rating = try values.decodeIfPresent(String.self, forKey: .user_rating)
    }

}

struct currentRideDatar : Codable {
    let cancel_status : String?
    enum CodingKeys: String, CodingKey {
        case cancel_status = "cancel_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cancel_status = try values.decodeIfPresent(String.self, forKey: .cancel_status)
    }

}


typealias OngoingRequestRideStatusData = OngoingRequestRideStatusModel

struct OngoingRequestRideStatusModel : Codable {
    let data : [OngoingRequestRideStatusDatar]?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([OngoingRequestRideStatusDatar].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct OngoingRequestRideStatusDatar : Codable {
    let ride : String?
    let msg : String?
    enum CodingKeys: String, CodingKey {
        case ride = "ride"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ride = try values.decodeIfPresent(String.self, forKey: .ride)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }
 }
