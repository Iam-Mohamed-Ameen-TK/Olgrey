//
//  LoginView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.modelContext) private var modelContext

    var body: some View {

        NavigationStack {

        ZStack {

            // MARK: - Background

            Image("login_background_light_mode")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Dark Overlay

            Color.black.opacity(0.10)
                .ignoresSafeArea()

            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {

                    VStack {

                        Spacer()

                        // MARK: Logo

                        Image("signup_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)

                        Text("Welcome Back")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(LinearGradient.beigeGold)
                            .padding(.top, 12)

                        Text("Sign in to continue")
                            .font(.system(size: 16))
                            .foregroundStyle(LinearGradient.beigeGold)
                            .opacity(0.85)
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
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .opacity(0.9)
                                    }
                                }

                                PrimaryButton(title: "Login") {
                                    viewModel.loginUser(modelContext: modelContext)
                                }

                                AuthDivider()

                                HStack(spacing: 25) {

                                    SocialLoginButton(type: .phone)

                                    SocialLoginButton(type: .google)

                                    SocialLoginButton(type: .apple)
                                }

                                HStack(spacing: 4) {

                                    Text("Don't have an account?")
                                        .foregroundStyle(LinearGradient.beigeGold)
                                        .opacity(0.85)

                                    Button {

                                    } label: {

                                        Text("Sign Up")
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .fontWeight(.bold)
                                    }
                                }
                                .padding(.top, 8)

                            }
                        }
                        .padding(.horizontal, 30)

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
        .navigationDestination(isPresented: $viewModel.navigateToMain) {
            MainTabView()
                .navigationBarHidden(true)
        }

        } // NavigationStack
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
            .modelContainer(for: UserProfileModel.self, inMemory: true)
    }
}
