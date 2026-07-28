//
//  LoginViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {

    @Published var login = LoginModel()

    @Published var isPasswordVisible = false

    @Published var isLoading = false

    @Published var showAlert = false
    @Published var alertMessage = ""

    func loginUser() {

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

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {

            self.isLoading = false

            print("Login Success")
        }
    }
}
