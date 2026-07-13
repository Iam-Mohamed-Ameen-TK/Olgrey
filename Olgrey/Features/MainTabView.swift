//
//  MainTabView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct MainTabView: View {

    @State private var selectedTab: AppTab = .profile

    var body: some View {

        ZStack(alignment: .bottom) {

            // MARK: - Page Content
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                        .transition(.opacity)
                case .chat:
                    ChatView()
                        .transition(.opacity)
                case .settings:
                    SettingsView()
                        .transition(.opacity)
                case .profile:
                    ProfileView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: selectedTab)
            // Give content space so it doesn't hide behind the tab bar
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 90)
            }

            // MARK: - Floating Glass Tab Bar
            VStack(spacing: 0) {
                AppTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
