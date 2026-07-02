//
//  VerificationModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation

struct VerificationModel {
    var dob: String = ""
    var gender: String = ""
    var email: String = ""
    var phone: String = ""
    var isEmailVerified: Bool = false
    var isPhoneVerified: Bool = false
}

enum VerificationChannel {
    case email
    case phone
}
