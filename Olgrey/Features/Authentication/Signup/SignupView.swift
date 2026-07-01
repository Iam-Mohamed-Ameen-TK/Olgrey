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

        ZStack {

            // MARK: - Background
            Color.black.ignoresSafeArea()

            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {

                    VStack(spacing: 20) {

                        Spacer()

                        Text("Create Account")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)

                        Text("Sign up to get started")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.bottom, 20)

                        // MARK: - Fields
                        GlassView {

                            VStack(spacing: 20) {

                                AppTextField(
                                    title: "Full Name",
                                    systemImage: "person.fill",
                                    text: $viewModel.name
                                )

                                AppTextField(
                                    title: "Email",
                                    systemImage: "envelope.fill",
                                    text: $viewModel.email,
                                    keyboardType: .emailAddress
                                )

                                AppSecureField(
                                    title: "Password",
                                    text: $viewModel.password,
                                    isVisible: $viewModel.isPasswordVisible
                                )

                                AppSecureField(
                                    title: "Confirm Password",
                                    text: $viewModel.confirmPassword,
                                    isVisible: $viewModel.isConfirmPasswordVisible
                                )

                                PrimaryButton(title: "Create Account") {
                                    viewModel.signup()
                                }

                                HStack(spacing: 4) {

                                    Text("Already have an account?")
                                        .foregroundColor(.white.opacity(0.75))

                                    Button {
                                        dismiss()
                                    } label: {
                                        Text("Login")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                        .padding(.horizontal, 24)

                        Spacer()
                    }
                    .frame(minHeight: geometry.size.height)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Sign Up"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
