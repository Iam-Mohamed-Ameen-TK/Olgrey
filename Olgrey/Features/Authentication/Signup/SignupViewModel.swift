//
//  SignupViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine
import SwiftData

final class SignupViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var agreedToTerms: Bool = false

    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false

    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    @Published var navigateToVerification: Bool = false

    func signup(modelContext: ModelContext) {

        guard !name.isEmpty else {
            alertMessage = "Please enter your name."
            showAlert = true
            return
        }

        guard !email.isEmpty else {
            alertMessage = "Please enter your email."
            showAlert = true
            return
        }

        guard !password.isEmpty else {
            alertMessage = "Please enter a password."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }

        guard agreedToTerms else {
            alertMessage = "Please agree to the Terms of Service and Privacy Policy."
            showAlert = true
            return
        }

        // Save user's name to local DB
        let descriptor = FetchDescriptor<UserProfileModel>()
        let existingProfiles = (try? modelContext.fetch(descriptor)) ?? []

        let profile: UserProfileModel
        if let existing = existingProfiles.first {
            profile = existing
        } else {
            profile = UserProfileModel()
            modelContext.insert(profile)
        }

        profile.fullName = name
        try? modelContext.save()

        // Navigate to verification step
        navigateToVerification = true
    }
}
