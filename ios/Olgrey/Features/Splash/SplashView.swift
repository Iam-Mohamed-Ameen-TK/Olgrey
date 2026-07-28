//
//  SplashView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        Group {
            if viewModel.isReady {
                // Navigate to Login or Home based on auth state
                LoginView()
            } else {
                ZStack {
                    Color.accentColor.ignoresSafeArea()

                    VStack(spacing: 16) {
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)

                        Text("Olgrey")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear {
            viewModel.start()
        }
    }
}
