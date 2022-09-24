//
//  SecondBookingModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 20/09/22.
//

import Foundation

typealias SecondBookingData = SecondBookingModel

struct SecondBookingModel : Codable {
    let message : String?
    let data : [SecondBookingDatar]?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case data = "data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([SecondBookingDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct SecondBookingDatar : Codable {
    let gsacard : String?
    let profileid : String?
    let acctid : String?
    let auoptout : String?
    let postal : String?
    let expiry : String?
    let defaultacct : String?
    let accttype : String?
    let cofpermission : String?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case gsacard = "gsacard"
        case profileid = "profileid"
        case acctid = "acctid"
        case auoptout = "auoptout"
        case postal = "postal"
        case expiry = "expiry"
        case defaultacct = "defaultacct"
        case accttype = "accttype"
        case cofpermission = "cofpermission"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gsacard = try values.decodeIfPresent(String.self, forKey: .gsacard)
        profileid = try values.decodeIfPresent(String.self, forKey: .profileid)
        acctid = try values.decodeIfPresent(String.self, forKey: .acctid)
        auoptout = try values.decodeIfPresent(String.self, forKey: .auoptout)
        postal = try values.decodeIfPresent(String.self, forKey: .postal)
        expiry = try values.decodeIfPresent(String.self, forKey: .expiry)
        defaultacct = try values.decodeIfPresent(String.self, forKey: .defaultacct)
        accttype = try values.decodeIfPresent(String.self, forKey: .accttype)
        cofpermission = try values.decodeIfPresent(String.self, forKey: .cofpermission)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}

typealias PromoCodeValidationData = PromoCodeValidationModel

struct PromoCodeValidationModel : Codable {
    let message : String?
     let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
         case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
         status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
//{"msg":"Card added successfully.","status":"1"}
typealias addNewCardData = addNewCardModel

struct addNewCardModel : Codable {
    let message : String?
     let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
         case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
         status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

typealias createNewRideData = createNewRideModel

struct createNewRideModel : Codable {
    let message : String?
    let data : [createNewRideDatar]?

     let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case data = "data"

         case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([createNewRideDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct createNewRideDatar : Codable {
    let message : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
