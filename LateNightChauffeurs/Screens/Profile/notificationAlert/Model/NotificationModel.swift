//
//  NotificationModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import Foundation

typealias NotificationData = NotificationModel

struct NotificationModel : Codable {
    let data : [NotificationDatar]?
    let status : String?
    let message : String?
    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([NotificationDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct NotificationDatar : Codable {
    let id : String?
    let title : String?
    let message : String?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case message = "message"
        case date = "date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}
