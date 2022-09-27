//
//  ChatModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import Foundation

typealias UserChatData = UserChatModel

struct UserChatModel : Codable {
    let data : [UserChatDatar]?
    let status : String?
    let message : String?
    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([UserChatDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct UserChatDatar : Codable {
    let profileImageReciever : String?
    let profileImageSender : String?
    let mesage : String?
    let date : String?
    let sender : String?
    let reciever : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case profileImageReciever = "profileImageReciever"
        case profileImageSender = "profileImageSender"
        case mesage = "mesage"
        case date = "date"
        case sender = "sender"
        case reciever = "reciever"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileImageReciever = try values.decodeIfPresent(String.self, forKey: .profileImageReciever)
        profileImageSender = try values.decodeIfPresent(String.self, forKey: .profileImageSender)
        mesage = try values.decodeIfPresent(String.self, forKey: .mesage)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        sender = try values.decodeIfPresent(String.self, forKey: .sender)
        reciever = try values.decodeIfPresent(String.self, forKey: .reciever)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
