//
//  SignupView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Sign up to get started")
                .font(.subheadline)
                .foregroundColor(.secondary)

            VStack(spacing: 16) {
                AppTextField(placeholder: "Full Name", text: $viewModel.name)
                AppTextField(placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                AppTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                AppTextField(placeholder: "Confirm Password", text: $viewModel.confirmPassword, isSecure: true)
            }

            PrimaryButton(title: "Create Account", action: {
                viewModel.signup()
            }, isLoading: viewModel.isLoading)

            Button("Already have an account? Login") {
                dismiss()
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
