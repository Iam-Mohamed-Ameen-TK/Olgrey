//
//  PrimaryButton.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct PrimaryButton: View {

    let title: String
    var trailingIcon: String? = nil
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack {

                if isLoading {

                    ProgressView()
                        .tint(Color(red: 244/255, green: 231/255, blue: 213/255)) // Beige tint

                } else {

                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(LinearGradient.beigeGold)

                    if let icon = trailingIcon {
                        Image(systemName: icon)
                            .foregroundStyle(LinearGradient.beigeGold)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(
                Group {
                    if isDisabled {
                        Color.white.opacity(0.3)
                    } else {
                        LinearGradient.darkRed
                    }
                }
            )
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
