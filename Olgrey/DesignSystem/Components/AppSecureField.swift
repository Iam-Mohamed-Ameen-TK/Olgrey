//
//  AppSecureField.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct AppSecureField: View {

    let title: String

    @Binding var text: String

    @Binding var isVisible: Bool

    var body: some View {

        HStack(spacing: 15) {

            Image(systemName: "lock.fill")
                .foregroundStyle(LinearGradient.beigeGold)
                .opacity(0.7)
                .frame(width: 20)

            if isVisible {

                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(title)
                            .foregroundStyle(LinearGradient.beigeGold)
                            .opacity(0.5)
                    }
                    .foregroundStyle(LinearGradient.beigeGold)

            } else {

                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(title)
                            .foregroundStyle(LinearGradient.beigeGold)
                            .opacity(0.5)
                    }
                    .foregroundStyle(LinearGradient.beigeGold)
            }

            Button {

                withAnimation(.easeInOut(duration: 0.25)) {
                    isVisible.toggle()
                }

            } label: {

                Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundStyle(LinearGradient.beigeGold)
                    .opacity(0.7)
            }

        }
        .padding(.horizontal, 16)
        .frame(height: 46)
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
        .cornerRadius(16)
    }
}

// MARK: - Preview

struct AppSecureField_Previews: PreviewProvider {

    struct HiddenPreview: View {

        @State private var password = "Password123"
        @State private var isVisible = false

        var body: some View {
            AppSecureField(
                title: "Password",
                text: $password,
                isVisible: $isVisible
            )
            .padding()
            .background(Color.black)
        }
    }

    struct VisiblePreview: View {

        @State private var password = "Password123"
        @State private var isVisible = true

        var body: some View {
            AppSecureField(
                title: "Password",
                text: $password,
                isVisible: $isVisible
            )
            .padding()
            .background(Color.black)
        }
    }

    static var previews: some View {
        Group {
            HiddenPreview()
                .previewDisplayName("Hidden Password")

            VisiblePreview()
                .previewDisplayName("Visible Password")
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
