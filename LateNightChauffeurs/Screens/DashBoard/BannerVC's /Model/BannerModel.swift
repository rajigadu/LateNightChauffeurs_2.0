//
//  BannerModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 04/10/22.
//

import Foundation

typealias BannerData = BannerModel
struct BannerModel : Codable {
    let message : String?
    let status : String?
    let data : [BannerDatar]?
    let delay : String?
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
        case delay = "delay"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([BannerDatar].self, forKey: .data)
        delay = try values.decodeIfPresent(String.self, forKey: .delay)
    }

}
struct BannerDatar : Codable {
    let banner_logo : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case banner_logo = "banner_logo"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banner_logo = try values.decodeIfPresent(String.self, forKey: .banner_logo)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
