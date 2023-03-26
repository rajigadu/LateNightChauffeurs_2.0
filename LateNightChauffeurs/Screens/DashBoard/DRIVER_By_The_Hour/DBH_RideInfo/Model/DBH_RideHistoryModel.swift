//
//  DBH_RideHistoryModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 14/03/23.
//

import Foundation

typealias DBH_RideHistoryData = DBH_RideHistoryModel

struct DBH_RideHistoryModel : Codable {
    let message : String?
    let status : String?
    let bannercount : String?
    let rating : String?
    let data : DBH_FutureRideInfoDatarrrr?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case bannercount = "bannercount"
        case rating = "rating"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        bannercount = try values.decodeIfPresent(String.self, forKey: .bannercount)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        data = try values.decodeIfPresent(DBH_FutureRideInfoDatarrrr.self, forKey: .data)
    }

}

struct DBH_FutureRideInfoDatarrrr : Codable {
    let future_edit_ride_status : [DBH_Future_edit_ride_status]?
    let ride : [DBH_RideHistoryDataR]?

    enum CodingKeys: String, CodingKey {

        case future_edit_ride_status = "future_edit_ride_status"
        case ride = "ride"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        future_edit_ride_status = try values.decodeIfPresent([DBH_Future_edit_ride_status].self, forKey: .future_edit_ride_status)
        ride = try values.decodeIfPresent([DBH_RideHistoryDataR].self, forKey: .ride)
    }

}

struct DBH_Future_edit_ride_status : Codable {
    let future_edit_ride_status : String?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case future_edit_ride_status = "future_edit_ride_status"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        future_edit_ride_status = try values.decodeIfPresent(String.self, forKey: .future_edit_ride_status)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

struct DBH_RideHistoryDataR : Codable {
    let id : String?
    let user_id : String?
    let card_id : String?
    let time : String?
    let date : String?
    let otherdate : String?
    let booking_type : String?
    let pickup_address : String?
    let pickup_lat : String?
    let pickup_long : String?
    let city_pickup : String?
    let city_pickup2 : String?
    let hourly_rate_while_ride_completed :  String?
    let notes : String?
    let status : String?
    let driver_status : String?
    let driver_id_for_future_ride : String?
    let future_accept : String?
    let ride_assign_status : String?
    let ride_start_time : String?
    let cancel_status : String?
    let cancel_time : String?
    let ride_cancel_by : String?
    let promo : String?
    let tip_status : String?
    let admin_charge : String?
    let reason : String?
    let second : String?
    let acctid : String?
    let platform : String?
    let extra_charges : String?
    let end_date : String?
    let end_time : String?
    let ride_total_time : String?
    let car_transmission : String?
    let feedback_status : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case card_id = "card_id"
        case time = "time"
        case date = "date"
        case otherdate = "otherdate"
        case booking_type = "booking_type"
        case pickup_address = "pickup_address"
        case pickup_lat = "pickup_lat"
        case pickup_long = "pickup_long"
        case city_pickup = "city_pickup"
        case city_pickup2 = "city_pickup2"
        case notes = "notes"
        case status = "status"
        case driver_status = "driver_status"
        case driver_id_for_future_ride = "driver_id_for_future_ride"
        case hourly_rate_while_ride_completed = "hourly_rate_while_ride_completed"
        case future_accept = "future_accept"
        case ride_assign_status = "ride_assign_status"
        case ride_start_time = "ride_start_time"
        case cancel_status = "cancel_status"
        case cancel_time = "cancel_time"
        case ride_cancel_by = "ride_cancel_by"
        case promo = "promo"
        case tip_status = "tip_status"
        case admin_charge = "admin_charge"
        case reason = "reason"
        case second = "second"
        case acctid = "acctid"
        case platform = "platform"
        case extra_charges = "extra_charges"
        case end_date = "end_date"
        case end_time = "end_time"
        case ride_total_time = "ride_total_time"
        case car_transmission = "car_transmission"
        case feedback_status = "feedback_status"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
        pickup_long = try values.decodeIfPresent(String.self, forKey: .pickup_long)
        city_pickup = try values.decodeIfPresent(String.self, forKey: .city_pickup)
        city_pickup2 = try values.decodeIfPresent(String.self, forKey: .city_pickup2)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
        driver_id_for_future_ride = try values.decodeIfPresent(String.self, forKey: .driver_id_for_future_ride)
        future_accept = try values.decodeIfPresent(String.self, forKey: .future_accept)
        ride_assign_status = try values.decodeIfPresent(String.self, forKey: .ride_assign_status)
        ride_start_time = try values.decodeIfPresent(String.self, forKey: .ride_start_time)
        cancel_status = try values.decodeIfPresent(String.self, forKey: .cancel_status)
        hourly_rate_while_ride_completed = try values.decode(String.self, forKey: .hourly_rate_while_ride_completed)
        cancel_time = try values.decodeIfPresent(String.self, forKey: .cancel_time)
        ride_cancel_by = try values.decodeIfPresent(String.self, forKey: .ride_cancel_by)
        promo = try values.decodeIfPresent(String.self, forKey: .promo)
        tip_status = try values.decodeIfPresent(String.self, forKey: .tip_status)
        admin_charge = try values.decodeIfPresent(String.self, forKey: .admin_charge)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        second = try values.decodeIfPresent(String.self, forKey: .second)
        acctid = try values.decodeIfPresent(String.self, forKey: .acctid)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
        extra_charges = try values.decodeIfPresent(String.self, forKey: .extra_charges)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        ride_total_time = try values.decodeIfPresent(String.self, forKey: .ride_total_time)
        car_transmission = try values.decodeIfPresent(String.self, forKey: .car_transmission)
        feedback_status = try values.decodeIfPresent(String.self, forKey: .feedback_status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}


//typealias RideInfoData = RideInfoModel
//
//struct RideInfoModel : Codable {
//    let message : String?
//    let status : String?
//    let bannercount : String?
//    let rating : String?
//    let data : FutureRideInfoDatarrrr?
//
//    enum CodingKeys: String, CodingKey {
//
//        case message = "message"
//        case status = "status"
//        case bannercount = "bannercount"
//        case rating = "rating"
//        case data = "data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        bannercount = try values.decodeIfPresent(String.self, forKey: .bannercount)
//        rating = try values.decodeIfPresent(String.self, forKey: .rating)
//        data = try values.decodeIfPresent(FutureRideInfoDatarrrr.self, forKey: .data)
//    }
//
//}
//
//struct FutureRideInfoDatarrrr : Codable {
//    let future_edit_ride_status : [Future_edit_ride_status]?
//    let ride : [RideInfoDatar]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case future_edit_ride_status = "future_edit_ride_status"
//        case ride = "ride"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        future_edit_ride_status = try values.decodeIfPresent([Future_edit_ride_status].self, forKey: .future_edit_ride_status)
//        ride = try values.decodeIfPresent([RideInfoDatar].self, forKey: .ride)
//    }
//
//}
//
//struct Future_edit_ride_status : Codable {
//    let future_edit_ride_status : String?
//    let id : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case future_edit_ride_status = "future_edit_ride_status"
//        case id = "id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        future_edit_ride_status = try values.decodeIfPresent(String.self, forKey: .future_edit_ride_status)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//    }
//
//}
//
//struct RideInfoDatar : Codable {
//    let id : String?
//    let user_id : String?
//    let card_id : String?
//    let numstops : String?
//    let time : String?
//    let date : String?
//    let otherdate : String?
//    let booking_type : String?
//    let pickup_address : String?
//    let drop_address : String?
//    let pickup_lat : String?
//    let pickup_long : String?
//    let d_lat : String?
//    let d_long : String?
//    let city_pickup : String?
//    let city_pickup2 : String?
//    let city_drop : String?
//    let distance : String?
//    let arrival_time : String?
//    let arrival_distance : String?
//    let notes : String?
//    let status : String?
//    let driver_status : String?
//    let driver_id_for_future_ride : String?
//    let future_partner_id : String?
//    let partner_status : String?
//    let future_accept : String?
//    let future_accept_partner : String?
//    let future_dummy_partner : String?
//    let future_ride_start : String?
//    let current_ride_start : String?
//    let ride_start_time : String?
//    let waiting_charges_start : String?
//    let estimation_time : String?
//    let estimated_price : String?
//    let car_transmission : String?
//    let cancel_status : String?
//    let cancel_time : String?
//    let ride_cancel_by : String?
//    let unplanned_stops : String?
//    let promo : String?
//    let driver_program_id : String?
//    let partner_program_id : String?
//    let feedback_status : String?
//    let tip_status : String?
//    let admin_charge : String?
//    let reason : String?
//    let second : String?
//    let acctid : String?
//    let platform : String?
//    let extra_charges : String?
//    let created_at : String?
//    let estimation_price : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case user_id = "user_id"
//        case card_id = "card_id"
//        case numstops = "numstops"
//        case time = "time"
//        case date = "date"
//        case otherdate = "otherdate"
//        case booking_type = "booking_type"
//        case pickup_address = "pickup_address"
//        case drop_address = "drop_address"
//        case pickup_lat = "pickup_lat"
//        case pickup_long = "pickup_long"
//        case d_lat = "d_lat"
//        case d_long = "d_long"
//        case city_pickup = "city_pickup"
//        case city_pickup2 = "city_pickup2"
//        case city_drop = "city_drop"
//        case distance = "distance"
//        case arrival_time = "arrival_time"
//        case arrival_distance = "arrival_distance"
//        case notes = "notes"
//        case status = "status"
//        case driver_status = "driver_status"
//        case driver_id_for_future_ride = "driver_id_for_future_ride"
//        case future_partner_id = "future_partner_id"
//        case partner_status = "partner_status"
//        case future_accept = "future_accept"
//        case future_accept_partner = "future_accept_partner"
//        case future_dummy_partner = "future_dummy_partner"
//        case future_ride_start = "future_ride_start"
//        case current_ride_start = "current_ride_start"
//        case ride_start_time = "ride_start_time"
//        case waiting_charges_start = "waiting_charges_start"
//        case estimation_time = "estimation_time"
//        case estimated_price = "estimated_price"
//        case car_transmission = "car_transmission"
//        case cancel_status = "cancel_status"
//        case cancel_time = "cancel_time"
//        case ride_cancel_by = "ride_cancel_by"
//        case unplanned_stops = "unplanned_stops"
//        case promo = "promo"
//        case driver_program_id = "driver_program_id"
//        case partner_program_id = "partner_program_id"
//        case feedback_status = "feedback_status"
//        case tip_status = "tip_status"
//        case admin_charge = "admin_charge"
//        case reason = "reason"
//        case second = "second"
//        case acctid = "acctid"
//        case platform = "platform"
//        case extra_charges = "extra_charges"
//        case created_at = "created_at"
//        case estimation_price = "estimation_price"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
//        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
//        numstops = try values.decodeIfPresent(String.self, forKey: .numstops)
//        time = try values.decodeIfPresent(String.self, forKey: .time)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
//        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
//        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
//        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
//        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
//        pickup_long = try values.decodeIfPresent(String.self, forKey: .pickup_long)
//        d_lat = try values.decodeIfPresent(String.self, forKey: .d_lat)
//        d_long = try values.decodeIfPresent(String.self, forKey: .d_long)
//        city_pickup = try values.decodeIfPresent(String.self, forKey: .city_pickup)
//        city_pickup2 = try values.decodeIfPresent(String.self, forKey: .city_pickup2)
//        city_drop = try values.decodeIfPresent(String.self, forKey: .city_drop)
//        distance = try values.decodeIfPresent(String.self, forKey: .distance)
//        arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
//        arrival_distance = try values.decodeIfPresent(String.self, forKey: .arrival_distance)
//        notes = try values.decodeIfPresent(String.self, forKey: .notes)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
//        driver_id_for_future_ride = try values.decodeIfPresent(String.self, forKey: .driver_id_for_future_ride)
//        future_partner_id = try values.decodeIfPresent(String.self, forKey: .future_partner_id)
//        partner_status = try values.decodeIfPresent(String.self, forKey: .partner_status)
//        future_accept = try values.decodeIfPresent(String.self, forKey: .future_accept)
//        future_accept_partner = try values.decodeIfPresent(String.self, forKey: .future_accept_partner)
//        future_dummy_partner = try values.decodeIfPresent(String.self, forKey: .future_dummy_partner)
//        future_ride_start = try values.decodeIfPresent(String.self, forKey: .future_ride_start)
//        current_ride_start = try values.decodeIfPresent(String.self, forKey: .current_ride_start)
//        ride_start_time = try values.decodeIfPresent(String.self, forKey: .ride_start_time)
//        waiting_charges_start = try values.decodeIfPresent(String.self, forKey: .waiting_charges_start)
//        estimation_time = try values.decodeIfPresent(String.self, forKey: .estimation_time)
//        estimated_price = try values.decodeIfPresent(String.self, forKey: .estimated_price)
//        car_transmission = try values.decodeIfPresent(String.self, forKey: .car_transmission)
//        cancel_status = try values.decodeIfPresent(String.self, forKey: .cancel_status)
//        cancel_time = try values.decodeIfPresent(String.self, forKey: .cancel_time)
//        ride_cancel_by = try values.decodeIfPresent(String.self, forKey: .ride_cancel_by)
//        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
//        promo = try values.decodeIfPresent(String.self, forKey: .promo)
//        driver_program_id = try values.decodeIfPresent(String.self, forKey: .driver_program_id)
//        partner_program_id = try values.decodeIfPresent(String.self, forKey: .partner_program_id)
//        feedback_status = try values.decodeIfPresent(String.self, forKey: .feedback_status)
//        tip_status = try values.decodeIfPresent(String.self, forKey: .tip_status)
//        admin_charge = try values.decodeIfPresent(String.self, forKey: .admin_charge)
//        reason = try values.decodeIfPresent(String.self, forKey: .reason)
//        second = try values.decodeIfPresent(String.self, forKey: .second)
//        acctid = try values.decodeIfPresent(String.self, forKey: .acctid)
//        platform = try values.decodeIfPresent(String.self, forKey: .platform)
//        extra_charges = try values.decodeIfPresent(String.self, forKey: .extra_charges)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        estimation_price = try values.decodeIfPresent(String.self, forKey: .estimation_price)
//    }
//
//}
//
////MARK : ----  ------------------------------------------------------------------------------------------
//
//typealias PaymentHistoryData = PaymentHistoryModel
//
//struct PaymentHistoryModel : Codable {
//    let message : String?
//    let status : String?
//    let data : [PaymentHistoryDatar]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case message = "message"
//        case status = "status"
//        case data = "data"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        data = try values.decodeIfPresent([PaymentHistoryDatar].self, forKey: .data)
//    }
//
//}
//struct PaymentHistoryDatar : Codable {
//    let id : String?
//    let user_id : String?
//    let card_id : String?
//    let numstops : String?
//    let time : String?
//    let date : String?
//    let otherdate : String?
//    let booking_type : String?
//    let pickup_address : String?
//    let drop_address : String?
//    let pickup_lat : String?
//    let pickup_long : String?
//    let d_lat : String?
//    let d_long : String?
//    let city_pickup : String?
//    let city_pickup2 : String?
//    let city_drop : String?
//    let distance : String?
//    let arrival_time : String?
//    let arrival_distance : String?
//    let notes : String?
//    let status : String?
//    let driver_status : String?
//    let driver_id_for_future_ride : String?
//    let future_partner_id : String?
//    let partner_status : String?
//    let future_accept : String?
//    let future_accept_partner : String?
//    let future_dummy_partner : String?
//    let future_ride_start : String?
//    let current_ride_start : String?
//    let ride_start_time : String?
//    let waiting_charges_start : String?
//    let estimation_time : String?
//    let estimated_price : String?
//    let car_transmission : String?
//    let cancel_status : String?
//    let cancel_time : String?
//    let ride_cancel_by : String?
//    let unplanned_stops : String?
//    let promo : String?
//    let driver_program_id : String?
//    let partner_program_id : String?
//    let feedback_status : String?
//    let tip_status : String?
//    let admin_charge : String?
//    let reason : String?
//    let second : String?
//    let acctid : String?
//    let platform : String?
//    let extra_charges : String?
//    let created_at : String?
//    let rideid : String?
//    let booking_id : String?
//    let transaction_id : String?
//    let amount : String?
//    let payment_date : String?
//    let payment : String?
//    let waiting_time : String?
//    let waiting_amt : String?
//    let unplaned_waiting_amt : String?
//    let unplaned_stop_amt : String?
//    let planed_stop_amt : String?
//    let promo_amt : String?
//    let city_charges : String?
//    let ride_amt : String?
//    let extra_charge : String?
//    let pre_share : String?
//    let planned_stops_count : String?
//    let unplanned_stops_count : String?
//    let charge_for_waiting_time : String?
//    let charge_for_per_planned_stops : String?
//    let charge_for_per_unplanned_stop : String?
//    let payDateTime : String?
//    let tip_ammount : String?
//    let first_name : String?
//    let last_name : String?
//    let profile_pic: String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case user_id = "user_id"
//        case card_id = "card_id"
//        case numstops = "numstops"
//        case time = "time"
//        case date = "date"
//        case otherdate = "otherdate"
//        case booking_type = "booking_type"
//        case pickup_address = "pickup_address"
//        case drop_address = "drop_address"
//        case pickup_lat = "pickup_lat"
//        case pickup_long = "pickup_long"
//        case d_lat = "d_lat"
//        case d_long = "d_long"
//        case city_pickup = "city_pickup"
//        case city_pickup2 = "city_pickup2"
//        case city_drop = "city_drop"
//        case distance = "distance"
//        case arrival_time = "arrival_time"
//        case arrival_distance = "arrival_distance"
//        case notes = "notes"
//        case status = "status"
//        case driver_status = "driver_status"
//        case driver_id_for_future_ride = "driver_id_for_future_ride"
//        case future_partner_id = "future_partner_id"
//        case partner_status = "partner_status"
//        case future_accept = "future_accept"
//        case future_accept_partner = "future_accept_partner"
//        case future_dummy_partner = "future_dummy_partner"
//        case future_ride_start = "future_ride_start"
//        case current_ride_start = "current_ride_start"
//        case ride_start_time = "ride_start_time"
//        case waiting_charges_start = "waiting_charges_start"
//        case estimation_time = "estimation_time"
//        case estimated_price = "estimated_price"
//        case car_transmission = "car_transmission"
//        case cancel_status = "cancel_status"
//        case cancel_time = "cancel_time"
//        case ride_cancel_by = "ride_cancel_by"
//        case unplanned_stops = "unplanned_stops"
//        case promo = "promo"
//        case driver_program_id = "driver_program_id"
//        case partner_program_id = "partner_program_id"
//        case feedback_status = "feedback_status"
//        case tip_status = "tip_status"
//        case admin_charge = "admin_charge"
//        case reason = "reason"
//        case second = "second"
//        case acctid = "acctid"
//        case platform = "platform"
//        case extra_charges = "extra_charges"
//        case created_at = "created_at"
//        case rideid = "rideid"
//        case booking_id = "booking_id"
//        case transaction_id = "transaction_id"
//        case amount = "amount"
//        case payment_date = "payment_date"
//        case payment = "payment"
//        case waiting_time = "waiting_time"
//        case waiting_amt = "waiting_amt"
//        case unplaned_waiting_amt = "unplaned_waiting_amt"
//        case unplaned_stop_amt = "unplaned_stop_amt"
//        case planed_stop_amt = "planed_stop_amt"
//        case promo_amt = "promo_amt"
//        case city_charges = "city_charges"
//        case ride_amt = "ride_amt"
//        case extra_charge = "extra_charge"
//        case pre_share = "pre_share"
//        case planned_stops_count = "planned_stops_count"
//        case unplanned_stops_count = "unplanned_stops_count"
//        case charge_for_waiting_time = "charge_for_waiting_time"
//        case charge_for_per_planned_stops = "charge_for_per_planned_stops"
//        case charge_for_per_unplanned_stop = "charge_for_per_unplanned_stop"
//        case payDateTime = "PayDateTime"
//        case tip_ammount = "tip_ammount"
//        case first_name = "first_name"
//        case last_name = "last_name"
//        case profile_pic = "profile_pic"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
//        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
//        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
//        numstops = try values.decodeIfPresent(String.self, forKey: .numstops)
//        time = try values.decodeIfPresent(String.self, forKey: .time)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
//        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
//        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
//        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
//        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
//        pickup_long = try values.decodeIfPresent(String.self, forKey: .pickup_long)
//        d_lat = try values.decodeIfPresent(String.self, forKey: .d_lat)
//        d_long = try values.decodeIfPresent(String.self, forKey: .d_long)
//        city_pickup = try values.decodeIfPresent(String.self, forKey: .city_pickup)
//        city_pickup2 = try values.decodeIfPresent(String.self, forKey: .city_pickup2)
//        city_drop = try values.decodeIfPresent(String.self, forKey: .city_drop)
//        distance = try values.decodeIfPresent(String.self, forKey: .distance)
//        arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
//        arrival_distance = try values.decodeIfPresent(String.self, forKey: .arrival_distance)
//        notes = try values.decodeIfPresent(String.self, forKey: .notes)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
//        driver_id_for_future_ride = try values.decodeIfPresent(String.self, forKey: .driver_id_for_future_ride)
//        future_partner_id = try values.decodeIfPresent(String.self, forKey: .future_partner_id)
//        partner_status = try values.decodeIfPresent(String.self, forKey: .partner_status)
//        future_accept = try values.decodeIfPresent(String.self, forKey: .future_accept)
//        future_accept_partner = try values.decodeIfPresent(String.self, forKey: .future_accept_partner)
//        future_dummy_partner = try values.decodeIfPresent(String.self, forKey: .future_dummy_partner)
//        future_ride_start = try values.decodeIfPresent(String.self, forKey: .future_ride_start)
//        current_ride_start = try values.decodeIfPresent(String.self, forKey: .current_ride_start)
//        ride_start_time = try values.decodeIfPresent(String.self, forKey: .ride_start_time)
//        waiting_charges_start = try values.decodeIfPresent(String.self, forKey: .waiting_charges_start)
//        estimation_time = try values.decodeIfPresent(String.self, forKey: .estimation_time)
//        estimated_price = try values.decodeIfPresent(String.self, forKey: .estimated_price)
//        car_transmission = try values.decodeIfPresent(String.self, forKey: .car_transmission)
//        cancel_status = try values.decodeIfPresent(String.self, forKey: .cancel_status)
//        cancel_time = try values.decodeIfPresent(String.self, forKey: .cancel_time)
//        ride_cancel_by = try values.decodeIfPresent(String.self, forKey: .ride_cancel_by)
//        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
//        promo = try values.decodeIfPresent(String.self, forKey: .promo)
//        driver_program_id = try values.decodeIfPresent(String.self, forKey: .driver_program_id)
//        partner_program_id = try values.decodeIfPresent(String.self, forKey: .partner_program_id)
//        feedback_status = try values.decodeIfPresent(String.self, forKey: .feedback_status)
//        tip_status = try values.decodeIfPresent(String.self, forKey: .tip_status)
//        admin_charge = try values.decodeIfPresent(String.self, forKey: .admin_charge)
//        reason = try values.decodeIfPresent(String.self, forKey: .reason)
//        second = try values.decodeIfPresent(String.self, forKey: .second)
//        acctid = try values.decodeIfPresent(String.self, forKey: .acctid)
//        platform = try values.decodeIfPresent(String.self, forKey: .platform)
//        extra_charges = try values.decodeIfPresent(String.self, forKey: .extra_charges)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        rideid = try values.decodeIfPresent(String.self, forKey: .rideid)
//        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
//        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
//        amount = try values.decodeIfPresent(String.self, forKey: .amount)
//        payment_date = try values.decodeIfPresent(String.self, forKey: .payment_date)
//        payment = try values.decodeIfPresent(String.self, forKey: .payment)
//        waiting_time = try values.decodeIfPresent(String.self, forKey: .waiting_time)
//        waiting_amt = try values.decodeIfPresent(String.self, forKey: .waiting_amt)
//        unplaned_waiting_amt = try values.decodeIfPresent(String.self, forKey: .unplaned_waiting_amt)
//        unplaned_stop_amt = try values.decodeIfPresent(String.self, forKey: .unplaned_stop_amt)
//        planed_stop_amt = try values.decodeIfPresent(String.self, forKey: .planed_stop_amt)
//        promo_amt = try values.decodeIfPresent(String.self, forKey: .promo_amt)
//        city_charges = try values.decodeIfPresent(String.self, forKey: .city_charges)
//        ride_amt = try values.decodeIfPresent(String.self, forKey: .ride_amt)
//        extra_charge = try values.decodeIfPresent(String.self, forKey: .extra_charge)
//        pre_share = try values.decodeIfPresent(String.self, forKey: .pre_share)
//        planned_stops_count = try values.decodeIfPresent(String.self, forKey: .planned_stops_count)
//        unplanned_stops_count = try values.decodeIfPresent(String.self, forKey: .unplanned_stops_count)
//        charge_for_waiting_time = try values.decodeIfPresent(String.self, forKey: .charge_for_waiting_time)
//        charge_for_per_planned_stops = try values.decodeIfPresent(String.self, forKey: .charge_for_per_planned_stops)
//        charge_for_per_unplanned_stop = try values.decodeIfPresent(String.self, forKey: .charge_for_per_unplanned_stop)
//        payDateTime = try values.decodeIfPresent(String.self, forKey: .payDateTime)
//        tip_ammount = try values.decodeIfPresent(String.self, forKey: .tip_ammount)
//        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
//    }
//
//}
