//
//  VerificationView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import SwiftData

struct VerificationView: View {

    @StateObject private var viewModel: VerificationViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    init(fullName: String = "", email: String = "") {
        _viewModel = StateObject(wrappedValue: VerificationViewModel(fullName: fullName, email: email))
    }

    var body: some View {

        NavigationStack {

            ZStack {

                // MARK: - Background
                Image("login_background_light_mode")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                Color.black.opacity(0.35)
                    .ignoresSafeArea()

                GeometryReader { geometry in

                    ScrollView(showsIndicators: false) {

                        VStack(spacing: 0) {

                            // Back button
                            HStack {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(LinearGradient.beigeGold)
                                        .font(.system(size: 18, weight: .semibold))
                                        .padding(12)
                                        .background(Color.white.opacity(0.1))
                                        .clipShape(Circle())
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                            .padding(.bottom, 12)

                            // MARK: - Glass Card
                            GlassView {

                                VStack(spacing: 20) {

                                    // Header
                                    VStack(spacing: 6) {
                                        Text("Complete Your Profile")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundStyle(LinearGradient.beigeGold)

                                        Image(systemName: "sparkles")
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .font(.system(size: 11))

                                        Text("Just a few more details to get you set up.")
                                            .font(.system(size: 13))
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(LinearGradient.beigeGold)
                                            .opacity(0.8)
                                    }
                                    .padding(.bottom, 4)

                                    // MARK: - Email
                                    VStack(spacing: 4) {
                                        fieldTitle("Email Address")
                                        HStack(spacing: 10) {
                                            AppTextField(
                                                title: "Enter your email",
                                                systemImage: "envelope",
                                                text: $viewModel.email,
                                                keyboardType: .emailAddress
                                            )
                                            verifyButton(
                                                verified: viewModel.isEmailVerified
                                            ) {
                                                viewModel.sendEmailOTP()
                                            }
                                        }
                                        if viewModel.isEmailVerified {
                                            verifiedBadge("Email verified")
                                        }
                                    }

                                    // MARK: - Phone
                                    VStack(spacing: 4) {
                                        fieldTitle("Phone Number")
                                        HStack(spacing: 10) {
                                            AppTextField(
                                                title: "Enter your phone number",
                                                systemImage: "phone",
                                                text: $viewModel.phone,
                                                keyboardType: .phonePad
                                            )
                                            verifyButton(
                                                verified: viewModel.isPhoneVerified
                                            ) {
                                                viewModel.sendPhoneOTP()
                                            }
                                        }
                                        if viewModel.isPhoneVerified {
                                            verifiedBadge("Phone verified")
                                        }
                                    }

                                    // MARK: - DOB
                                    VStack(spacing: 4) {
                                        fieldTitle("Date of Birth")
                                        AppTextField(
                                            title: "DD / MM / YYYY",
                                            systemImage: "calendar",
                                            text: $viewModel.dob
                                        )
                                    }

                                    // MARK: - Gender
                                    VStack(spacing: 4) {
                                        fieldTitle("I am")
                                        GenderPicker(selected: $viewModel.gender)
                                    }

                                    // MARK: - Continue
                                    PrimaryButton(
                                        title: "Finish",
                                        trailingIcon: "arrow.right",
                                        isLoading: viewModel.isLoading,
                                        isDisabled: !viewModel.canProceed
                                    ) {
                                        viewModel.complete(modelContext: modelContext)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .frame(minHeight: geometry.size.height)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Verification"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }

            // MARK: - Navigation
            .navigationDestination(isPresented: $viewModel.navigateToEmailOTP) {
                OTPVerificationView(model: viewModel.emailOTPModel) {
                    viewModel.navigateToEmailOTP = false
                    viewModel.isEmailVerified = true
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToPhoneOTP) {
                OTPVerificationView(model: viewModel.phoneOTPModel) {
                    viewModel.navigateToPhoneOTP = false
                    viewModel.isPhoneVerified = true
                }
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Helpers

    private func fieldTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(LinearGradient.beigeGold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 4)
    }

    private func verifyButton(verified: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Group {
                if verified {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(LinearGradient.beigeGold)
                } else {
                    Text("Verify")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(LinearGradient.beigeGold)
                }
            }
            .frame(width: 60, height: 46)
            .background(verified ? AnyShapeStyle(LinearGradient.darkRed) : AnyShapeStyle(LinearGradient.darkRed.opacity(0.0)))
            .background(Color.white.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(LinearGradient.beigeGold.opacity(verified ? 0 : 0.3), lineWidth: 1)
            )
        }
        .disabled(verified)
    }

    private func verifiedBadge(_ label: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 11))
                .foregroundStyle(LinearGradient.beigeGold)
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(LinearGradient.beigeGold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 4)
    }
}

// MARK: - Gender Picker
struct GenderPicker: View {

    @Binding var selected: String

    private let options = ["Man", "Woman", "Non-binary", "Prefer not to say"]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                Button {
                    selected = option
                } label: {
                    Text(option)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(selected == option ? AnyShapeStyle(LinearGradient.beigeGold) : AnyShapeStyle(LinearGradient.beigeGold.opacity(0.5)))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(
                            selected == option
                                ? AnyShapeStyle(LinearGradient.darkRed)
                                : AnyShapeStyle(LinearGradient.darkRed.opacity(0.0))
                        )
                        .background(Color.white.opacity(0.08))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(
                                    selected == option
                                        ? LinearGradient.beigeGold.opacity(0.4)
                                        : LinearGradient.beigeGold.opacity(0.15),
                                    lineWidth: 1
                                )
                        )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview
struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(fullName: "Test User", email: "user@example.com")
            .preferredColorScheme(.dark)
            .modelContainer(for: UserProfileModel.self, inMemory: true)
    }
}
