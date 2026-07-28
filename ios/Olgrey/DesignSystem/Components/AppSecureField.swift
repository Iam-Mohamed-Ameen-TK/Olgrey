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
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 20)

            if isVisible {

                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(title)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .foregroundColor(.white)

            } else {

                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(title)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .foregroundColor(.white)
            }

            Button {

                withAnimation(.easeInOut(duration: 0.25)) {
                    isVisible.toggle()
                }

            } label: {

                Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.white.opacity(0.7))
            }

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
