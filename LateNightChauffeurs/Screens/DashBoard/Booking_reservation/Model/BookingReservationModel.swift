//
//  BookingReservationModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 18/09/22.
//

import Foundation
import UIKit
struct BookingModel {
    var userCurrentLocationLatitude = Double()
    var userCurrentLocationLongitude = Double()
    
    var userPickUplatitudeStr = String()
    var userPickUplongitudeStr = String()
    var userCurrentlatitudeStr = String()
    var userCurrentlongitudeStr = String()
    var userDroplatitudeStr = String()
    var userDroplongitudeStr = String()
    var userDropupCityStr = String()
    var userPickupCityStr = String()
    var rideDestinationLatitudeStr = String()
    var rideDestinationLongitudeStr = String()
//    var geoCoder = CLGeocoder()
//    var placeMark = CLPlacemark()
    var str_UserLoginID = String()
    var str_TodayDate = String()
    var selectedTextField = Int()
    var str_BookingRideType = String()
    var pickerView = UIPickerView()
    var ary_ChooseTypeRef = Array<Any>()
    var str_StartButtonClicked = String()
    var str_SelectedOneFromPickerview = String()
    var dict_SelectedActiveCardInfo = Dictionary<String,Any>()
    var dict_SelectedDestinationAddressInfo = Dictionary<String,Any>()
    var ary_StopList = Array<Any>()
    var ary_UpdateToServerArray = Array<Any>()
    var totalridedistance = String()
    var totalridetime = String()
//    BOOL isSelectedForFuture;
    var isSelectedCarTransmission = Bool()
    var driverlatitudeStr = String()
    var driverlongitudeStr = String()
    var dateFormatForFutureDate = DateFormatter()
    var str_CurrentDate = String()
    var str_CurrentTime = String()
    var str_CheckTransmissionStatus = String()
    var str_CardID = String()
    var str_SelectedBookingIDInEdit = String()
    var str_PromoCodeStr = String()
    var str_PromoCodesuccessStr = String()
    var Addcardetailsbtnstr = String()
    var pickupCityName = String()
    var dropOffCityName = String()
    var pickingdate = Date()
    var version = String()
    var Str_savedCardNumber = String()
    var Str_pic_Drop_TF_empty_add = String()
    var D_t_pickStatus = String()
    var EditCardNumber = String()
    var EditPromocode = String()
    var str_picktf_status = String()
    var str_droptf_status = String()

}
