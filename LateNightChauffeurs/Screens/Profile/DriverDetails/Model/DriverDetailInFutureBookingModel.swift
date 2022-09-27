//
//  DriverDetailInFutureBookingModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 26/09/22.
//

import Foundation

typealias DriverDetailInFutureBookingData = DriverDetailInFutureBookingModel

struct DriverDetailInFutureBookingModel : Codable {
    let message : String?
    let status : String?
    let data : DriverDetailInFutureBookingDatar?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(DriverDetailInFutureBookingDatar.self, forKey: .data)
    }

}

struct DriverDetailInFutureBookingDatar : Codable {
    let ride : DriverDetailInFutureBooking_Ride?
    let driver : DriverDetailInFutureBooking_Driver?
    let driver_rating : String?

    enum CodingKeys: String, CodingKey {

        case ride = "ride"
        case driver = "driver"
        case driver_rating = "driver_rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ride = try values.decodeIfPresent(DriverDetailInFutureBooking_Ride.self, forKey: .ride)
        driver = try values.decodeIfPresent(DriverDetailInFutureBooking_Driver.self, forKey: .driver)
        driver_rating = try values.decodeIfPresent(String.self, forKey: .driver_rating)
    }

}

struct DriverDetailInFutureBooking_Ride : Codable {
    let id : String?
    let user_id : String?
    let card_id : String?
    let numstops : String?
    let time : String?
    let date : String?
    let otherdate : String?
    let booking_type : String?
    let pickup_address : String?
    let drop_address : String?
    let pickup_lat : String?
    let pickup_long : String?
    let d_lat : String?
    let d_long : String?
    let city_pickup : String?
    let city_pickup2 : String?
    let city_drop : String?
    let distance : String?
    let arrival_time : String?
    let arrival_distance : String?
    let notes : String?
    let status : String?
    let driver_status : String?
    let driver_id_for_future_ride : String?
    let future_partner_id : String?
    let partner_status : String?
    let future_accept : String?
    let future_accept_partner : String?
    let future_dummy_partner : String?
    let future_ride_start : String?
    let current_ride_start : String?
    let ride_start_time : String?
    let waiting_charges_start : String?
    let estimation_time : String?
    let estimated_price : String?
    let car_transmission : String?
    let cancel_status : String?
    let cancel_time : String?
    let ride_cancel_by : String?
    let unplanned_stops : String?
    let promo : String?
    let driver_program_id : String?
    let partner_program_id : String?
    let feedback_status : String?
    let tip_status : String?
    let admin_charge : String?
    let reason : String?
    let second : String?
    let acctid : String?
    let platform : String?
    let extra_charges : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case card_id = "card_id"
        case numstops = "numstops"
        case time = "time"
        case date = "date"
        case otherdate = "otherdate"
        case booking_type = "booking_type"
        case pickup_address = "pickup_address"
        case drop_address = "drop_address"
        case pickup_lat = "pickup_lat"
        case pickup_long = "pickup_long"
        case d_lat = "d_lat"
        case d_long = "d_long"
        case city_pickup = "city_pickup"
        case city_pickup2 = "city_pickup2"
        case city_drop = "city_drop"
        case distance = "distance"
        case arrival_time = "arrival_time"
        case arrival_distance = "arrival_distance"
        case notes = "notes"
        case status = "status"
        case driver_status = "driver_status"
        case driver_id_for_future_ride = "driver_id_for_future_ride"
        case future_partner_id = "future_partner_id"
        case partner_status = "partner_status"
        case future_accept = "future_accept"
        case future_accept_partner = "future_accept_partner"
        case future_dummy_partner = "future_dummy_partner"
        case future_ride_start = "future_ride_start"
        case current_ride_start = "current_ride_start"
        case ride_start_time = "ride_start_time"
        case waiting_charges_start = "waiting_charges_start"
        case estimation_time = "estimation_time"
        case estimated_price = "estimated_price"
        case car_transmission = "car_transmission"
        case cancel_status = "cancel_status"
        case cancel_time = "cancel_time"
        case ride_cancel_by = "ride_cancel_by"
        case unplanned_stops = "unplanned_stops"
        case promo = "promo"
        case driver_program_id = "driver_program_id"
        case partner_program_id = "partner_program_id"
        case feedback_status = "feedback_status"
        case tip_status = "tip_status"
        case admin_charge = "admin_charge"
        case reason = "reason"
        case second = "second"
        case acctid = "acctid"
        case platform = "platform"
        case extra_charges = "extra_charges"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
        numstops = try values.decodeIfPresent(String.self, forKey: .numstops)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
        pickup_long = try values.decodeIfPresent(String.self, forKey: .pickup_long)
        d_lat = try values.decodeIfPresent(String.self, forKey: .d_lat)
        d_long = try values.decodeIfPresent(String.self, forKey: .d_long)
        city_pickup = try values.decodeIfPresent(String.self, forKey: .city_pickup)
        city_pickup2 = try values.decodeIfPresent(String.self, forKey: .city_pickup2)
        city_drop = try values.decodeIfPresent(String.self, forKey: .city_drop)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
        arrival_distance = try values.decodeIfPresent(String.self, forKey: .arrival_distance)
        notes = try values.decodeIfPresent(String.self, forKey: .notes)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
        driver_id_for_future_ride = try values.decodeIfPresent(String.self, forKey: .driver_id_for_future_ride)
        future_partner_id = try values.decodeIfPresent(String.self, forKey: .future_partner_id)
        partner_status = try values.decodeIfPresent(String.self, forKey: .partner_status)
        future_accept = try values.decodeIfPresent(String.self, forKey: .future_accept)
        future_accept_partner = try values.decodeIfPresent(String.self, forKey: .future_accept_partner)
        future_dummy_partner = try values.decodeIfPresent(String.self, forKey: .future_dummy_partner)
        future_ride_start = try values.decodeIfPresent(String.self, forKey: .future_ride_start)
        current_ride_start = try values.decodeIfPresent(String.self, forKey: .current_ride_start)
        ride_start_time = try values.decodeIfPresent(String.self, forKey: .ride_start_time)
        waiting_charges_start = try values.decodeIfPresent(String.self, forKey: .waiting_charges_start)
        estimation_time = try values.decodeIfPresent(String.self, forKey: .estimation_time)
        estimated_price = try values.decodeIfPresent(String.self, forKey: .estimated_price)
        car_transmission = try values.decodeIfPresent(String.self, forKey: .car_transmission)
        cancel_status = try values.decodeIfPresent(String.self, forKey: .cancel_status)
        cancel_time = try values.decodeIfPresent(String.self, forKey: .cancel_time)
        ride_cancel_by = try values.decodeIfPresent(String.self, forKey: .ride_cancel_by)
        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
        promo = try values.decodeIfPresent(String.self, forKey: .promo)
        driver_program_id = try values.decodeIfPresent(String.self, forKey: .driver_program_id)
        partner_program_id = try values.decodeIfPresent(String.self, forKey: .partner_program_id)
        feedback_status = try values.decodeIfPresent(String.self, forKey: .feedback_status)
        tip_status = try values.decodeIfPresent(String.self, forKey: .tip_status)
        admin_charge = try values.decodeIfPresent(String.self, forKey: .admin_charge)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        second = try values.decodeIfPresent(String.self, forKey: .second)
        acctid = try values.decodeIfPresent(String.self, forKey: .acctid)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
        extra_charges = try values.decodeIfPresent(String.self, forKey: .extra_charges)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}
struct DriverDetailInFutureBooking_Driver : Codable {
    let id : String?
    let driver_type : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let latitude : String?
    let longitude : String?
    let mobile : String?
    let password : String?
    let profile_pic : String?
    let adress1 : String?
    let adress2 : String?
    let city : String?
    let state : String?
    let zip : String?
    let country : String?
    let vehicle_type : String?
    let vehicle_model : String?
    let vehile_making_year : String?
    let age : String?
    let address : String?
    let dob : String?
    let vehicle_image : String?
    let license_image : String?
    let approved_status : String?
    let document_image : String?
    let abstract_image : String?
    let date_created : String?
    let login_status : String?
    let notification_status : String?
    let default_partner : String?
    let default_partner_id : String?
    let reward_program_id : String?
    let driver_time : String?
    let status : String?
    let app_version : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case driver_type = "driver_type"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case latitude = "latitude"
        case longitude = "longitude"
        case mobile = "mobile"
        case password = "password"
        case profile_pic = "profile_pic"
        case adress1 = "adress1"
        case adress2 = "adress2"
        case city = "city"
        case state = "state"
        case zip = "zip"
        case country = "country"
        case vehicle_type = "vehicle_type"
        case vehicle_model = "vehicle_model"
        case vehile_making_year = "vehile_making_year"
        case age = "age"
        case address = "address"
        case dob = "dob"
        case vehicle_image = "vehicle_image"
        case license_image = "license_image"
        case approved_status = "approved_status"
        case document_image = "document_image"
        case abstract_image = "abstract_image"
        case date_created = "date_created"
        case login_status = "login_status"
        case notification_status = "notification_status"
        case default_partner = "default_partner"
        case default_partner_id = "default_partner_id"
        case reward_program_id = "reward_program_id"
        case driver_time = "driver_time"
        case status = "status"
        case app_version = "app_version"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        driver_type = try values.decodeIfPresent(String.self, forKey: .driver_type)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        adress1 = try values.decodeIfPresent(String.self, forKey: .adress1)
        adress2 = try values.decodeIfPresent(String.self, forKey: .adress2)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        vehicle_model = try values.decodeIfPresent(String.self, forKey: .vehicle_model)
        vehile_making_year = try values.decodeIfPresent(String.self, forKey: .vehile_making_year)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        vehicle_image = try values.decodeIfPresent(String.self, forKey: .vehicle_image)
        license_image = try values.decodeIfPresent(String.self, forKey: .license_image)
        approved_status = try values.decodeIfPresent(String.self, forKey: .approved_status)
        document_image = try values.decodeIfPresent(String.self, forKey: .document_image)
        abstract_image = try values.decodeIfPresent(String.self, forKey: .abstract_image)
        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
        login_status = try values.decodeIfPresent(String.self, forKey: .login_status)
        notification_status = try values.decodeIfPresent(String.self, forKey: .notification_status)
        default_partner = try values.decodeIfPresent(String.self, forKey: .default_partner)
        default_partner_id = try values.decodeIfPresent(String.self, forKey: .default_partner_id)
        reward_program_id = try values.decodeIfPresent(String.self, forKey: .reward_program_id)
        driver_time = try values.decodeIfPresent(String.self, forKey: .driver_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        app_version = try values.decodeIfPresent(String.self, forKey: .app_version)
    }

}
