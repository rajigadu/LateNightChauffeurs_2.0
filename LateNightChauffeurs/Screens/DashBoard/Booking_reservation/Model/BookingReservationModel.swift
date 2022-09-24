//
//  BookingReservationModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import Foundation
import UIKit
//struct BookingModel {
//    var pickUpLatitude : String
//    var pickUpLongitude: String
//    var pickUpDropAddress: String
//    var dropLatitude: String
//    var dropLongitude: String
//    var bookingDate: String
//    var bookingTime: String
//    var bookingComment: String
//    var bookingStops: [String]
//    var bookingStopsNo: String
//    var carTransMission: String
//    var promoCode: String
//    var cardID: String
//    var bookingType: String
//    var appVersion: String
//}

typealias EstinatePriceModelData = EstinatePriceModel


struct EstinatePriceModel : Codable {
    let data : [EstinatePriceModelDatar]?
    let status : String?
    let message : String?
    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([EstinatePriceModelDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct EstinatePriceModelDatar : Codable {
    let planned_charges : String?
    let estimate_price : String?
    let estimate_time : String?
    let distance : String?

    enum CodingKeys: String, CodingKey {

        case planned_charges = "planned_charges"
        case estimate_price = "estimate_price"
        case estimate_time = "estimate_time"
        case distance = "distance"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        planned_charges = try values.decodeIfPresent(String.self, forKey: .planned_charges)
        estimate_price = try values.decodeIfPresent(String.self, forKey: .estimate_price)
        estimate_time = try values.decodeIfPresent(String.self, forKey: .estimate_time)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
    }

}
/*
 
 "userid":701
 "card_id":9413634822968978
 "acctid":18
 
 "nstops":"1"
 "savedrop":["WXP4+8P2, Kopperapadu, Chinakotha Palle, Andhra Pradesh 523303, India"]
 
 "platitude":"16.0294422"
 "plongitude":"79.9447885"
 "pickup_address":"Kommala Padu, Andhra Pradesh 523303, India"
 "pickup_city":"Kommala Padu"
 
 "drop_address":"Addanki, Andhra Pradesh 523201, India"
 "dlatitude":"15.810707"
 "dlongitude":"79.9724245"
 "drop_city":"Addanki"
 
 "notes":"hi hello"

 
 "booking_type": "2" @"future booking" or "1" @"As Soon As Possible"
 "date":"24-09-2022"
 "time":"07:03 PM"
 "transmission":"automatic"  checked@"manual"   unchecked@"automatic"
 
 
 "promo":""
 
 "version":"1.0.30"
 */

//{
//"userid":"701",
//"card_id":"9413634822968978",
//"acctid":"18",
//"nstops":"1",
//"savedrop":["WXP4+8P2, Kopperapadu, Chinakotha Palle, Andhra Pradesh 523303, India"],
//"platitude":"16.0294422",
//"plongitude":"79.9447885",
//"pickup_address":"Kommala Padu, Andhra Pradesh 523303, India",
//"pickup_city":"Kommala Padu",
//"drop_address":"Addanki, Andhra Pradesh 523201, India",
//"dlatitude":"15.810707",
//"dlongitude":"79.9724245",
//"drop_city":"Addanki",
//"notes":"hi hello",
//"booking_type": "2",
//"date":"24-09-2022",
//"time":"07:03 PM",
//"transmission":"automatic",
//"promo":"",
//"version":"yes",
//}

struct BookingModel {
    var userid: String,
    card_id: String,
    acctid: String,
    nstops: String,
    savedrop: [String],
    platitude: String,
    plongitude: String,
    pickup_address: String,
    pickup_city: String,
    drop_address: String,
    dlatitude: String,
    dlongitude: String,
    drop_city: String,
    notes: String,
    booking_type: String,
    date: String,
    time: String,
    transmission: String,
    promo: String,
    version: String
}

