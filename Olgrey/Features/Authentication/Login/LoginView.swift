//
//  LoginView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign in to continue")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                VStack(spacing: 16) {
                    AppTextField(placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                    AppTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                }

                PrimaryButton(title: "Login", action: {
                    viewModel.login()
                }, isLoading: viewModel.isLoading)

                NavigationLink("Don't have an account? Sign Up") {
                    SignupView()
                }
                .font(.subheadline)

                Spacer()
            }
            .padding(.horizontal, 24)
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
    }
}
