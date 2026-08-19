//
//  VerificationViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine
import SwiftData

final class VerificationViewModel: ObservableObject {

    @Published var fullName: String = ""
    @Published var dob: String = ""
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""

    @Published var isEmailVerified: Bool = false
    @Published var isPhoneVerified: Bool = false

    @Published var navigateToEmailOTP: Bool = false
    @Published var navigateToPhoneOTP: Bool = false

    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    // Pre-fill from signup
    init(fullName: String = "", email: String = "") {
        self.fullName = fullName
        self.email = email
    }

    var emailOTPModel: OTPVerificationModel {
        OTPVerificationModel(channel: .email, destination: email)
    }

    var phoneOTPModel: OTPVerificationModel {
        OTPVerificationModel(channel: .phone, destination: phone)
    }

    var canProceed: Bool {
        isEmailVerified && isPhoneVerified && !dob.isEmpty && !gender.isEmpty
    }

    func sendEmailOTP() {
        guard !email.isEmpty else {
            alertMessage = "Please enter your email address."
            showAlert = true
            return
        }
        navigateToEmailOTP = true
    }

    func sendPhoneOTP() {
        guard !phone.isEmpty else {
            alertMessage = "Please enter your phone number."
            showAlert = true
            return
        }
        navigateToPhoneOTP = true
    }

    func complete(modelContext: ModelContext) {
        guard canProceed else {
            alertMessage = "Please verify your email and phone, and fill in all fields."
            showAlert = true
            return
        }
        isLoading = true

        // Fetch existing profile or create a new one
        let descriptor = FetchDescriptor<UserProfileModel>()
        let existingProfiles = (try? modelContext.fetch(descriptor)) ?? []

        let profile: UserProfileModel
        if let existing = existingProfiles.first {
            profile = existing
        } else {
            profile = UserProfileModel()
            modelContext.insert(profile)
        }

        // Save all collected data to the local DB
        profile.fullName = fullName
        profile.email    = email
        profile.phone    = phone

        try? modelContext.save()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = false
            print("Profile saved to local DB successfully")
        }
    }
}
