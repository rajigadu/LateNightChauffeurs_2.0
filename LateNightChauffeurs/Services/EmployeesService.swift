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
    func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String, completion: @escaping (_ success: Bool, _ results: ProfileUserData?, _ error: String?) -> ())
    //MARK: - get Cancel Ride Info
   // func requestForGetCancelInfoServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ProfileUserData?, _ error: String?) -> ())
    
}

//MARK: - Login
class ApiService: LateNightChauffeursUSERServiceProtocol {
    
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
    func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String, completion: @escaping (Bool, ProfileUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        
        HttpRequestHelper().uploadImagePOST(url: API_URl.API_UPDATEPROFILE_URL, params: perams, fileName: fileName, image: picImage, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ProfileUserData.self, from: data!)
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
    //MARK: - Get Cancel Ride Info
    func requestForGetCancelInfoServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChangePasswordUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CANCELRIDEAMOUNT_URL, params: perams, httpHeader: .application_json) { success, data in
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
