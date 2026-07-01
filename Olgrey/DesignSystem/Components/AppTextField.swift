//
//  AppTextField.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct AppTextField: View {

    let title: String
    var systemImage: String = "person.fill"
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {

        HStack(spacing: 15) {

            Image(systemName: systemImage)
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 20)

            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(title)
                        .foregroundColor(.white.opacity(0.5))
                }
                .foregroundColor(.white)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding()
        .frame(height: 58)
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
        .cornerRadius(16)
    }
}

// MARK: - Preview

struct AppTextField_Previews: PreviewProvider {

    struct PreviewWrapper: View {

        @State private var email = ""

        var body: some View {

            VStack(spacing: 20) {

                AppTextField(
                    title: "Email",
                    systemImage: "envelope.fill",
                    text: $email,
                    keyboardType: .emailAddress
                )

                AppTextField(
                    title: "Username",
                    systemImage: "person.fill",
                    text: $email
                )
            }
            .padding()
            .background(Color.black)
        }
    }

    static var previews: some View {
        PreviewWrapper()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
