//
//  LoginUser.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

typealias UserData = LoginedUser

// MARK: - Employee
//struct LoginedUser: Codable {
//    let message: String?
//    let loginStatus: String?
//    let paymentCardStatus: String?
//    let LoginedUserData: LoginedUserData?
//
//    enum CodingKeys: String, CodingKey {
//        case message = "msg"
//        case loginStatus = "status"
//        case paymentCardStatus = "card_status"
//        case LoginedUserData = "data"
//    }
//    internal init(message: String?, loginStatus:String?, paymentCardStatus:String?, LoginedUserData: LoginedUserData?) {
//         self.message = message
//         self.loginStatus = loginStatus
//         self.paymentCardStatus = paymentCardStatus
//         self.LoginedUserData = LoginedUserData
//     }
//}
//
//struct LoginedUserData: Codable {
//    let id: String
//    let firstName: String
//    let lastName: String
//    let emailAddress: String
//    let profilePic: String
//    let mobileNumber: String
//    let status: String
//    let loginStatus: String
//    let date: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case emailAddress = "email_address"
//        case profilePic = "profile_pic"
//        case mobileNumber = "mobile"
//        case status
//        case loginStatus = "login_status"
//        case date
//    }
//}


struct LoginedUser : Codable {
    let msg : String?
    let status : String?
    let card_status : String?
    let data : [LoginedUserData]?

    enum CodingKeys: String, CodingKey {

        case msg = "msg"
        case status = "status"
        case card_status = "card_status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        card_status = try values.decodeIfPresent(String.self, forKey: .card_status)
        data = try values.decodeIfPresent([LoginedUserData].self, forKey: .data)
    }

}

struct LoginedUserData : Codable {
    let id : String?
    let first_name : String?
    let last_name : String?
    let email_address : String?
    let profile_pic : String?
    let mobile : String?
    let status : String?
    let login_status : String?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email_address = "email_address"
        case profile_pic = "profile_pic"
        case mobile = "mobile"
        case status = "status"
        case login_status = "login_status"
        case date = "date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email_address = try values.decodeIfPresent(String.self, forKey: .email_address)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        login_status = try values.decodeIfPresent(String.self, forKey: .login_status)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}
