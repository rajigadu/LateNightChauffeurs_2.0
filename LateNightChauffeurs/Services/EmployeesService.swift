//
//  EmployeesService.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

protocol LateNightChauffeursUSERServiceProtocol {
    func getLoginedUserDetails(_ perams :Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: UserData?, _ error: String?) -> ())
}

class LoginedService: LateNightChauffeursUSERServiceProtocol {

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

