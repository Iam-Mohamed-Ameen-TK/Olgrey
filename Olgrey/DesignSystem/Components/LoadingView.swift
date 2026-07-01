//
//  LoadingView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct LoadingView: View {

    var message: String = "Loading..."

    var body: some View {

        ZStack {

            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 16) {

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)

                Text(message)
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            .padding(32)
            .background(Color.white.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
            )
            .cornerRadius(20)
        }
    }
}
