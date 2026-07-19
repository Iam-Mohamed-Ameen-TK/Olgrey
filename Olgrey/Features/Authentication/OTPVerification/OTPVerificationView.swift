//
//  OTPVerificationView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct OTPVerificationView: View {

    @StateObject private var viewModel: OTPVerificationViewModel
    @Environment(\.dismiss) private var dismiss

    // Callback when OTP is successfully verified
    var onVerified: () -> Void

    init(model: OTPVerificationModel, onVerified: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: OTPVerificationViewModel(model: model))
        self.onVerified = onVerified
    }

    var body: some View {

        ZStack {

            // MARK: - Background
            Image("login_background_light_mode")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Color.black.opacity(0.35)
                .ignoresSafeArea()

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

                Spacer()

                // MARK: - Glass Card
                GlassView {
                    VStack(spacing: 28) {

                        // Icon
                        ZStack {
                            Circle()
                                .fill(LinearGradient.darkRed.opacity(0.15))
                                .frame(width: 72, height: 72)

                            Image(systemName: viewModel.model.channel == .email ? "envelope.badge.fill" : "phone.badge.fill")
                                .font(.system(size: 28))
                                .foregroundStyle(LinearGradient.darkRed)
                        }

                        // Title & Subtitle
                        VStack(spacing: 8) {
                            Text(viewModel.title)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(LinearGradient.beigeGold)

                            Text(viewModel.subtitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(LinearGradient.beigeGold)
                                .opacity(0.75)
                        }

                        // OTP Input
                        OTPInputView(digits: $viewModel.otpDigits)

                        // Verify Button
                        PrimaryButton(
                            title: "Verify",
                            trailingIcon: "checkmark",
                            isLoading: viewModel.isLoading
                        ) {
                            viewModel.verifyOTP()
                        }

                        // Resend
                        HStack(spacing: 4) {
                            Text("Didn't receive a code?")
                                .foregroundStyle(LinearGradient.beigeGold)
                                .opacity(0.75)
                                .font(.system(size: 13))

                            if viewModel.canResend {
                                Button {
                                    viewModel.resendOTP()
                                } label: {
                                    Text("Resend")
                                        .foregroundStyle(LinearGradient.darkRed)
                                        .fontWeight(.bold)
                                        .font(.system(size: 13))
                                }
                            } else {
                                Text("Resend in \(viewModel.resendCountdown)s")
                                    .foregroundStyle(LinearGradient.beigeGold)
                                    .opacity(0.5)
                                    .font(.system(size: 13))
                            }
                        }
                    }
                }
                .padding(.horizontal, 28)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.isVerified) { verified in
            if verified { onVerified() }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.title),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - OTP Input
struct OTPInputView: View {

    @Binding var digits: [String]
    @FocusState private var focusedIndex: Int?

    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<6, id: \.self) { index in
                OTPDigitField(
                    digit: $digits[index],
                    isFocused: focusedIndex == index
                ) {
                    // On change: move focus forward/backward
                    if digits[index].count > 1 {
                        digits[index] = String(digits[index].last!)
                    }
                    
                    if !digits[index].isEmpty && index < 5 {
                        focusedIndex = index + 1
                    } else if digits[index].isEmpty && index > 0 {
                        focusedIndex = index - 1
                    }
                }
                .focused($focusedIndex, equals: index)
            }
        }
        .onAppear { focusedIndex = 0 }
    }
}

struct OTPDigitField: View {

    @Binding var digit: String
    var isFocused: Bool
    var onChange: () -> Void

    var body: some View {
        TextField("", text: $digit)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.system(size: 22, weight: .bold))
            .foregroundStyle(LinearGradient.beigeGold)
            .frame(width: 46, height: 54)
            .background(Color.white.opacity(isFocused ? 0.15 : 0.07))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isFocused
                            ? AnyShapeStyle(LinearGradient.darkRed)
                            : AnyShapeStyle(LinearGradient.beigeGold.opacity(0.2)),
                        lineWidth: isFocused ? 1.5 : 1
                    )
            )
            .onChange(of: digit) { _ in onChange() }
    }
}

// MARK: - Preview
struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OTPVerificationView(
                model: OTPVerificationModel(channel: .email, destination: "user@example.com"),
                onVerified: {}
            )
            .previewDisplayName("Email OTP")

            OTPVerificationView(
                model: OTPVerificationModel(channel: .phone, destination: "+91 98765 43210"),
                onVerified: {}
            )
            .previewDisplayName("Phone OTP")
        }
        .preferredColorScheme(.dark)
    }
}
