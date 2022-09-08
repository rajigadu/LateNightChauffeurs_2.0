//
//  UserViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

struct LonedUserViewModel {
    let message: String
    let loginStatus: String
    let paymentCardStatus: String
    let LoginedUserData: LonedUserViewModelData
}

struct LonedUserViewModelData {
    let id: String
    let firstName: String
    let lastName: String
    let emailAddress: String
    let profilePic: String
    let mobileNumber: String
    let status: String
    let loginStatus: String
    let date: String
}
