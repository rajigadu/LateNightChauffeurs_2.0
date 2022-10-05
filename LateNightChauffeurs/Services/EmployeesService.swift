//
//  EmployeesService.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation
import UIKit

protocol LateNightChauffeursUSERServiceProtocol {
    //MARK: Login
    func getLoginedUserDetails(_ perams :Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: UserData?, _ error: String?) -> ())
    //MARK: Forgot Password
    func requestForForgotPasswordServices(_ perams: Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: ForgotPasswordUserData?, _ error: String?) -> ())
    //MARK: Registration
    func requestForRegistrationServices(_ perams: Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: RegistrationUserData?, _ error: String?) -> ())
    //MARK: Logout
    func requestForLogoutServices(_ perams: Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: SideMenuUserData?, _ error: String?) -> ())
    //MARK: Contact US
    func requestForContactUsServices(_ perams: Dictionary<String,String>,  completion: @escaping (_ success: Bool, _ results: ContactUsUserData?, _ error: String?) -> ())
    //MARK: Change Password
    func requestForChangePasswordServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChangePasswordUserData?, _ error: String?) -> ())
    //MARK: Edit Profile
    func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String,profileStruct : uploadImage, completion: @escaping (_ success: Bool, _ results: ProfileUserData?, _ error: String?) -> ())
    //MARK: - get Estimate Price
    func requestForGetEstimatePriceServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: EstinatePriceModelData?, _ error: String?) -> ())
    //MARK: - Get saved card list
    func requestForGetSavedCardListServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, SecondBookingData?, String?) -> ())
    //MARK: - Get validate promocode
    func requestForGetvalidatepromocodeServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PromoCodeValidationData?, String?) -> ())
    //MARK: - Add new card
    func requestForAddNewCardServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, addNewCardData?, String?) -> ())
    //MARK: - create new Ride
    func requestForcreateNewRideAPIServices(_ perams: Dictionary<String, Any>, completion: @escaping (Bool, createNewRideData?, String?) -> ())
    //MARK: - Edit Ride
    func requestForEditRideAPIServices(_ perams: Dictionary<String, Any>, completion: @escaping (Bool, createNewRideData?, String?) -> ())
    //MARK: - Remove Card
    func requestForRemoveCardServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, addNewCardData?, String?) -> ())
    //MARK: - Payment history
    func requestForPaymentHistoryServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PaymentHistoryData?, String?) -> ())
    //MARK: - RIDE INFO
    func requestForRideInfoServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideInfoData?, String?) -> ())
    //MARK: - Payment summary
    func requestForPaymentSummaryServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PaymentSummaryData?, String?) -> ())
    //MARK: - submit tip payment summary
    func requestForSubmitFeedBackServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideHistoryTipData?, String?) -> ())
    //MARK: - StopsList
    func requestForStopsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, StopsData?, String?) -> ())
    //MARK: - Get Ride Info
    func requestForDriverDetailInFutureBookingServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverDetailInFutureBookingData?, String?) -> ())
    //MARK: - Edit Ride Conformation
    func requestForEditRideConformationServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, EditRideConfirmData?, String?) -> ())
    //MARK: - Cancel Ride information
    func requestForCancelRideServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ())
    //MARK: - Cancel Ride Amount
    func requestForCancelRideAmountServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideAmountData?, String?) -> ())
    //MARK: - Chat History
    func requestForChatViewServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, UserChatData?, String?) -> ())
    //MARK: - Notification List
    func requestForNotificationServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, NotificationData?, String?) -> ())
    //MARK: - Banner Data 1
    func requestForbannerServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, BannerData?, String?) -> ())
    
    //MARK: - get Google key
    func requestForgetgooglekeyListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DashBoardUserData?, String?) -> ())
    
    //MARK: - CURRENT RIDE INFO API
    func requestForCURRENTRIDEINFOAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, currentRideData?, String?) -> ())
    
    //MARK: - ONGOING RIDE REQUEST API
    func requestForONGOINGRIDEREQUESTAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, OngoingRequestRideStatusData?, String?) -> ())
    
}


class ApiService: LateNightChauffeursUSERServiceProtocol {
    //MARK: - Existing ride Edit
    func requestForEditRideAPIServices(_ perams: Dictionary<String, Any>, completion: @escaping (Bool, createNewRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_EDITUSERRIDEREQUEST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(createNewRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
    
    //MARK: - Login
    func getLoginedUserDetails(_ perams :Dictionary<String,String>, completion: @escaping (Bool, UserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_LOGIN_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(UserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Forgot Password
extension ApiService {
    func requestForForgotPasswordServices(_ perams :Dictionary<String,String>, completion: @escaping (Bool, ForgotPasswordUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_FORGETPASSWORD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ForgotPasswordUserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Registration
extension ApiService {
    func requestForRegistrationServices(_ perams :Dictionary<String,String>, completion: @escaping (Bool, RegistrationUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_REGISTRATION_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RegistrationUserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Logout
extension ApiService {
    func requestForLogoutServices(_ perams :Dictionary<String,String>, completion: @escaping (Bool, SideMenuUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_LOGOUT_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(SideMenuUserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Contact US
extension ApiService {
    func requestForContactUsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ContactUsUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CONTACTUS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ContactUsUserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Change Password
extension ApiService {
    func requestForChangePasswordServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChangePasswordUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CHANGEPASSWORD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChangePasswordUserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Edit Profile
extension ApiService {
//    func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String, completion: @escaping (Bool, ProfileUserData?, String?) -> ()) {
        
        func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String, profileStruct : uploadImage, completion: @escaping (Bool, ProfileUserData?, String?) -> ()) {

        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        
//        HttpRequestHelper().uploadImagePOST(url: API_URl.API_UPDATEPROFILE_URL, params: perams, fileName: fileName, image: picImage, httpHeader: .application_json) { success, data in
//            if success {
//                do {
//                    let model = try JSONDecoder().decode(ProfileUserData.self, from: data!)
//                    completion(true, model, nil)
//                } catch {
//                    completion(false, nil, I18n.ModelDecodeErrorString)
//                }
//            } else {
//                completion(false, nil, I18n.GetRequestFailedString)
//            }
//        }
        
        HttpRequestHelper().uploadImagePOST(url: API_URl.API_UPDATEPROFILE_URL, params: perams, fileName: fileName, picImage: picImage,httpHeader: .application_json, profileStruct : profileStruct) { success, data in
            if success {
                do {
                    //let model = try JSONDecoder().decode(ProfileUserData.self, from: data!)
                    completion(true, data, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - get Estimate Price
    func requestForGetEstimatePriceServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, EstinatePriceModelData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_ESTIMATEDPRICE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(EstinatePriceModelData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - get Saved Card list
    func requestForGetSavedCardListServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, SecondBookingData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_USERSAVEDCREDITCARDLIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(SecondBookingData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    //MARK: - get validate promo code
    func requestForGetvalidatepromocodeServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PromoCodeValidationData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_Promocode_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(PromoCodeValidationData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    //MARK: - get validate promo code
    func requestForAddNewCardServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, addNewCardData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_ADDCREDITCARD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(addNewCardData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - get Create New Ride
    func requestForcreateNewRideAPIServices(_ perams: Dictionary<String, Any>, completion: @escaping (Bool, createNewRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_USERRIDEREQUEST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(createNewRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - get Create New Ride
    func requestForRemoveCardServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, addNewCardData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_REMOVESAVEDUSERCREDITCARD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(addNewCardData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
//MARK: - Payment history
    func requestForPaymentHistoryServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PaymentHistoryData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_USERRIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(PaymentHistoryData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - RIDE INFO
    func requestForRideInfoServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideInfoData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CURRENTFUTURERIDE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideInfoData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - Payment data
    func requestForPaymentSummaryServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PaymentSummaryData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_USERPAYMENTSUMMARY_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(PaymentSummaryData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - submit tip payment data
    func requestForSubmitFeedBackServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideHistoryTipData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_FEEDBACK_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideHistoryTipData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    //MARK: - StopsList
    func requestForStopsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, StopsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CURRENTRIDESTOPLIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(StopsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - Get Ride Info
    func requestForDriverDetailInFutureBookingServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverDetailInFutureBookingData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_USERFUTURERIDEDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverDetailInFutureBookingData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    //MARK: - Edit Ride Conformation
    func requestForEditRideConformationServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, EditRideConfirmData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_IS_EDITABLE_RIDEINFO_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(EditRideConfirmData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    //MARK: - Cancel Ride info
    func requestForCancelRideServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_USERFUTURECANCELRIDE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    //MARK: - Cancel Ride Amount
    func requestForCancelRideAmountServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideAmountData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CANCELRIDEAMOUNT_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideAmountData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - Chat History
    func requestForChatViewServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, UserChatData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_USER_CHATWITHDRIVER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(UserChatData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

extension ApiService {
    //MARK: - Notification List
    func requestForNotificationServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, NotificationData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_RichNotification_url, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(NotificationData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}



extension ApiService {
    //MARK: - get Create New Ride
    func requestForEditRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, createNewRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_EDITUSERRIDEREQUEST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(createNewRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
   
//MARK: - Banner Data 1
extension ApiService {
    //MARK: - get Create New Ride
    func requestForbannerServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, BannerData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_BANNERADS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(BannerData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - get Google key
extension ApiService {
    //MARK: - get Create New Ride
    func requestForgetgooglekeyListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DashBoardUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.Api_GET_GOOLE_KEY, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DashBoardUserData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - CURRENT RIDE INFO API
extension ApiService {
    //MARK: - get Create New Ride
    func requestForCURRENTRIDEINFOAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, currentRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_USER_CURRENTRIDEDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(currentRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - ONGOING RIDE REQUEST API
extension ApiService {
    //MARK: - get Create New Ride
    func requestForONGOINGRIDEREQUESTAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, OngoingRequestRideStatusData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().POST(url: API_URl.API_ONGOING_REQUESTSRIDE, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(OngoingRequestRideStatusData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
