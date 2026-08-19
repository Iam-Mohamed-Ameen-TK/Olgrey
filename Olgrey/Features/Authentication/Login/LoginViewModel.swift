//
//  LoginViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine
import SwiftData

final class LoginViewModel: ObservableObject {

    @Published var login = LoginModel()

    @Published var isPasswordVisible = false

    @Published var isLoading = false

    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var navigateToMain = false

    func loginUser(modelContext: ModelContext) {

        guard !login.email.isEmpty else {
            alertMessage = "Please enter your email."
            showAlert = true
            return
        }

        guard !login.password.isEmpty else {
            alertMessage = "Please enter your password."
            showAlert = true
            return
        }

        isLoading = true

        // Save user's email to local DB
        let descriptor = FetchDescriptor<UserProfileModel>()
        let existingProfiles = (try? modelContext.fetch(descriptor)) ?? []

        let profile: UserProfileModel
        if let existing = existingProfiles.first {
            profile = existing
        } else {
            profile = UserProfileModel()
            modelContext.insert(profile)
        }

        profile.email = login.email
        try? modelContext.save()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            self.navigateToMain = true
        }
    }
}
