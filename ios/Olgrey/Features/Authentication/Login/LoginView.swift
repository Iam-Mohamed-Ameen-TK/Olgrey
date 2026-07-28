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

        ZStack {

            // MARK: - Background

            Image("login_background_light_mode")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Dark Overlay

            Color.black.opacity(0.30)
                .ignoresSafeArea()

            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {

                    VStack {

                        Spacer()

                        // MARK: Logo

                        Image("app_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)

                        Text("Interact")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 12)

                        Text("Real people. Real connections.")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.bottom, 35)

                        // MARK: Glass Card

                        GlassView {

                            VStack(spacing: 20) {

                                AppTextField(
                                    title: "Email",
                                    systemImage: "envelope.fill",
                                    text: $viewModel.login.email
                                )

                                AppSecureField(
                                    title: "Password",
                                    text: $viewModel.login.password,
                                    isVisible: $viewModel.isPasswordVisible
                                )

                                HStack {

                                    Spacer()

                                    Button {

                                    } label: {

                                        Text("Forgot Password?")
                                            .font(.footnote)
                                            .foregroundColor(.white.opacity(0.8))
                                    }
                                }

                                PrimaryButton(title: "Login") {
                                    viewModel.loginUser()
                                }

                                AuthDivider()

                                HStack(spacing: 25) {

                                    SocialLoginButton(type: .phone)

                                    SocialLoginButton(type: .google)

                                    SocialLoginButton(type: .apple)
                                }

                                HStack(spacing: 4) {

                                    Text("Don't have an account?")
                                        .foregroundColor(.white.opacity(0.75))

                                    Button {

                                    } label: {

                                        Text("Sign Up")
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
                title: Text("Login"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
