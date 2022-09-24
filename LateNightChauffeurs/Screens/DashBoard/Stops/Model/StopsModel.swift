//
//  StopsModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import Foundation

typealias StopsData = StopsModel
struct StopsModel : Codable {
    let message : String?
    let status : String?
    let data : [StopsDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([StopsDatar].self, forKey: .data)
    }

}
struct StopsDatar : Codable {
    let id : String?
    let ride_id : String?
    let location : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case ride_id = "ride_id"
        case location = "location"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        ride_id = try values.decodeIfPresent(String.self, forKey: .ride_id)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
