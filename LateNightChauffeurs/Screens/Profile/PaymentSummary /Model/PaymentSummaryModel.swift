//
//  PaymentSummaryModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import Foundation

typealias PaymentSummaryData = PaymentSummaryModel

struct PaymentSummaryModel : Codable {
    let message : String?
    let status : String?
    let data : [PaymentSummaryDatar]?
    let base_price : String?
    let total_fare : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
        case base_price = "base_price"
        case total_fare = "total_fare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([PaymentSummaryDatar].self, forKey: .data)
        base_price = try values.decodeIfPresent(String.self, forKey: .base_price)
        total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
    }

}
struct PaymentSummaryDatar : Codable {
    let tip_amount : String?
    let status : String?
    let ride_cancel_by : String?
    let id : String?
    let user_id : String?
    let booking_id : String?
    let transaction_id : String?
    let amount : String?
    let payment_date : String?
    let payment : String?
    let waiting_time : String?
    let waiting_amt : String?
    let unplaned_waiting_amt : String?
    let unplaned_stop_amt : String?
    let planed_stop_amt : String?
    let promo_amt : String?
    let city_charges : String?
    let ride_amt : String?
    let extra_charge : String?
    let pre_share : String?
    let planned_stops_count : String?
    let unplanned_stops_count : String?
    let charge_for_waiting_time : String?
    let charge_for_per_planned_stops : String?
    let charge_for_per_unplanned_stop : String?
    let payDateTime : String?

    enum CodingKeys: String, CodingKey {

        case tip_amount = "tip_amount"
        case status = "status"
        case ride_cancel_by = "ride_cancel_by"
        case id = "id"
        case user_id = "user_id"
        case booking_id = "booking_id"
        case transaction_id = "transaction_id"
        case amount = "amount"
        case payment_date = "payment_date"
        case payment = "payment"
        case waiting_time = "waiting_time"
        case waiting_amt = "waiting_amt"
        case unplaned_waiting_amt = "unplaned_waiting_amt"
        case unplaned_stop_amt = "unplaned_stop_amt"
        case planed_stop_amt = "planed_stop_amt"
        case promo_amt = "promo_amt"
        case city_charges = "city_charges"
        case ride_amt = "ride_amt"
        case extra_charge = "extra_charge"
        case pre_share = "pre_share"
        case planned_stops_count = "planned_stops_count"
        case unplanned_stops_count = "unplanned_stops_count"
        case charge_for_waiting_time = "charge_for_waiting_time"
        case charge_for_per_planned_stops = "charge_for_per_planned_stops"
        case charge_for_per_unplanned_stop = "charge_for_per_unplanned_stop"
        case payDateTime = "PayDateTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tip_amount = try values.decodeIfPresent(String.self, forKey: .tip_amount)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        ride_cancel_by = try values.decodeIfPresent(String.self, forKey: .ride_cancel_by)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        payment_date = try values.decodeIfPresent(String.self, forKey: .payment_date)
        payment = try values.decodeIfPresent(String.self, forKey: .payment)
        waiting_time = try values.decodeIfPresent(String.self, forKey: .waiting_time)
        waiting_amt = try values.decodeIfPresent(String.self, forKey: .waiting_amt)
        unplaned_waiting_amt = try values.decodeIfPresent(String.self, forKey: .unplaned_waiting_amt)
        unplaned_stop_amt = try values.decodeIfPresent(String.self, forKey: .unplaned_stop_amt)
        planed_stop_amt = try values.decodeIfPresent(String.self, forKey: .planed_stop_amt)
        promo_amt = try values.decodeIfPresent(String.self, forKey: .promo_amt)
        city_charges = try values.decodeIfPresent(String.self, forKey: .city_charges)
        ride_amt = try values.decodeIfPresent(String.self, forKey: .ride_amt)
        extra_charge = try values.decodeIfPresent(String.self, forKey: .extra_charge)
        pre_share = try values.decodeIfPresent(String.self, forKey: .pre_share)
        planned_stops_count = try values.decodeIfPresent(String.self, forKey: .planned_stops_count)
        unplanned_stops_count = try values.decodeIfPresent(String.self, forKey: .unplanned_stops_count)
        charge_for_waiting_time = try values.decodeIfPresent(String.self, forKey: .charge_for_waiting_time)
        charge_for_per_planned_stops = try values.decodeIfPresent(String.self, forKey: .charge_for_per_planned_stops)
        charge_for_per_unplanned_stop = try values.decodeIfPresent(String.self, forKey: .charge_for_per_unplanned_stop)
        payDateTime = try values.decodeIfPresent(String.self, forKey: .payDateTime)
    }

}


typealias EditRideConfirmData = EditRideConfirmModel

struct EditRideConfirmModel : Codable {
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
