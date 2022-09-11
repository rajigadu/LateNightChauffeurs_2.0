//
//  LoginUser.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

typealias UserData = LoginedUser

// MARK: - LoginedUser Details
struct LoginedUser : Codable {
    
    let message : String?
    let loginStatus : String?
    let paymentCardStatus : String?
    let userDetails : [LoginedUserData]?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case loginStatus = "status"
        case paymentCardStatus = "card_status"
        case userDetails = "data"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        paymentCardStatus = try values.decodeIfPresent(String.self, forKey: .paymentCardStatus)
        userDetails = try values.decodeIfPresent([LoginedUserData].self, forKey: .userDetails)
    }

}

struct LoginedUserData : Codable {
    
    let userId : String?
    let firstName : String?
    let lastName : String?
    let emailAddress : String?
    let profilePic : String?
    let mobileNumber : String?
    let status : String?
    let loginStatus : String?
    let loginDate : String?

    enum CodingKeys: String, CodingKey {

        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case emailAddress = "email_address"
        case profilePic = "profile_pic"
        case mobileNumber = "mobile"
        case status = "status"
        case loginStatus = "login_status"
        case loginDate = "date"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        emailAddress = try values.decodeIfPresent(String.self, forKey: .emailAddress)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        loginDate = try values.decodeIfPresent(String.self, forKey: .loginDate)
    }
}
