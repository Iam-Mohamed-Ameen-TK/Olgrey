//
//  OTPVerificationModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation

struct OTPVerificationModel {
    var otp: String = ""
    var channel: VerificationChannel
    var destination: String // email address or phone number
}
