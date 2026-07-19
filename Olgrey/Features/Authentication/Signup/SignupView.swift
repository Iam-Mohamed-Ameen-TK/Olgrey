//
//  SignupView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import SwiftData

struct SignupView: View {

    @StateObject private var viewModel = SignupViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var body: some View {

        NavigationStack {

            ZStack {

                // MARK: - Background
                Image("login_background_light_mode")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                Color.black.opacity(0.30)
                    .ignoresSafeArea()

                GeometryReader { geometry in
                    ScrollView(showsIndicators: false) {

                        VStack(spacing: 20) {

                            Spacer()
                                .frame(height: 20)

                            // MARK: - Glass Card
                            GlassView {

                                VStack(spacing: 10) {

                                    // Header
                                    VStack(spacing: 6) {
                                        Text("Create Your Account")
                                            .font(.system(size: 26, weight: .bold))
                                            .foregroundStyle(LinearGradient.beigeGold)

                                        Image("signup_logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 36)

                                        Text("Join Olgrey and start your journey\ntowards something meaningful.")
                                            .font(.system(size: 13))
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .opacity(0.85)
                                            .padding(.top, 2)
                                    }
                                    .padding(.bottom, 6)

                                    // Form Fields
                                    VStack(spacing: 4) {
                                        fieldTitle("Full Name")
                                        AppTextField(
                                            title: "Enter your full name",
                                            systemImage: "person",
                                            text: $viewModel.name
                                        )
                                    }

                                    VStack(spacing: 4) {
                                        fieldTitle("Password")
                                        AppSecureField(
                                            title: "Create a password",
                                            text: $viewModel.password,
                                            isVisible: $viewModel.isPasswordVisible
                                        )
                                    }

                                    VStack(spacing: 4) {
                                        fieldTitle("Confirm Password")
                                        AppSecureField(
                                            title: "Confirm your password",
                                            text: $viewModel.confirmPassword,
                                            isVisible: $viewModel.isConfirmPasswordVisible
                                        )
                                    }

                                    // Checkbox
                                    HStack(spacing: 10) {
                                        Button {
                                            viewModel.agreedToTerms.toggle()
                                        } label: {
                                            Image(systemName: viewModel.agreedToTerms ? "checkmark.square.fill" : "square")
                                                .foregroundStyle(LinearGradient.beigeGold)
                                        }

                                        Text("I agree to the Terms of Service and Privacy Policy")
                                            .font(.system(size: 12))
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .opacity(0.9)

                                        Spacer()
                                    }
                                    .padding(.vertical, 2)
	
                                    // Continue navigates to VerificationView
                                    PrimaryButton(
                                        title: "Continue",
                                        trailingIcon: "arrow.right",
                                        isLoading: viewModel.isLoading
                                    ) {
                                        viewModel.signup(modelContext: modelContext)
                                    }

                                    AuthDivider(text: "OR")

                                    HStack(spacing: 15) {
                                        SocialLoginButton(type: .google, isCapsule: true)
                                        SocialLoginButton(type: .apple, isCapsule: true)
                                    }

                                    HStack(spacing: 4) {
                                        Text("Already have an account?")
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .opacity(0.85)
                                            .font(.system(size: 13))

                                        Button {
                                            dismiss()
                                        } label: {
                                            Text("Log In")
                                                .foregroundStyle(LinearGradient.darkRed)
                                                .fontWeight(.bold)
                                                .font(.system(size: 13))
                                        }
                                    }
                                    .padding(.top, 2)
                                }
                            }
                            .padding(.horizontal, 24)

                            Spacer()
                                .frame(height: 20)
                        }
                        .frame(minHeight: geometry.size.height)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Sign Up"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(isPresented: $viewModel.navigateToVerification) {
                VerificationView(fullName: viewModel.name, email: viewModel.email)
            }
        }
        .navigationBarHidden(true)
    }

    private func fieldTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(LinearGradient.beigeGold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 4)
    }
}

// MARK: - Preview
struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .preferredColorScheme(.dark)
            .modelContainer(for: UserProfile.self, inMemory: true)
    }
}
