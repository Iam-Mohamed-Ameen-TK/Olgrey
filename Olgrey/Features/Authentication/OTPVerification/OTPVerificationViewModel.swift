//
//  OTPVerificationViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine

final class OTPVerificationViewModel: ObservableObject {

    @Published var otpDigits: [String] = Array(repeating: "", count: 6)
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isVerified: Bool = false

    // Resend timer
    @Published var resendCountdown: Int = 30
    @Published var canResend: Bool = false

    let model: OTPVerificationModel
    private var timerCancellable: AnyCancellable?

    init(model: OTPVerificationModel) {
        self.model = model
        startResendTimer()
    }

    var otpCode: String {
        otpDigits.joined()
    }

    var title: String {
        switch model.channel {
        case .email: return "Verify Email"
        case .phone: return "Verify Phone"
        }
    }

    var subtitle: String {
        switch model.channel {
        case .email:
            return "Enter the 6-digit code sent to\n\(model.destination)"
        case .phone:
            return "Enter the 6-digit code sent to\n\(model.destination)"
        }
    }

    func verifyOTP() {
        guard otpCode.count == 6 else {
            alertMessage = "Please enter the complete 6-digit code."
            showAlert = true
            return
        }

        isLoading = true

        // Simulate verification
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            self.isVerified = true
        }
    }

    func resendOTP() {
        guard canResend else { return }
        resendCountdown = 30
        canResend = false
        startResendTimer()
        // TODO: Call API to resend OTP
    }

    private func startResendTimer() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                if self.resendCountdown > 0 {
                    self.resendCountdown -= 1
                } else {
                    self.canResend = true
                    self.timerCancellable?.cancel()
                }
            }
    }
}
