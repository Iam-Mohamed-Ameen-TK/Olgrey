//
//  PrimaryButton.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack {

                if isLoading {

                    ProgressView()
                        .tint(.white)

                } else {

                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(isDisabled ? Color.white.opacity(0.3) : Color.white)
            .foregroundColor(isDisabled ? .white.opacity(0.5) : Color.black)
            .cornerRadius(16)
        }
        .disabled(isDisabled || isLoading)
    }
}

struct PrimaryButton_Previews: PreviewProvider {

    static var previews: some View {

        Group {

            PrimaryButton(title: "Login") {

            }
            .padding()
            .previewDisplayName("Default")

            PrimaryButton(
                title: "Login",
                isLoading: true
            ) {

            }
            .padding()
            .previewDisplayName("Loading")

            PrimaryButton(
                title: "Login",
                isDisabled: true
            ) {

            }
            .padding()
            .previewDisplayName("Disabled")
        }
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
