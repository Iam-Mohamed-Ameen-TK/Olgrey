//
//  AppTabBar.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

// MARK: - Tab Item Model
enum AppTab: Int, CaseIterable {
    case home
    case chat
    case settings
    case profile

    var icon: String {
        switch self {
        case .home:     return "house.fill"
        case .chat:     return "bubble.left.and.bubble.right.fill"
        case .settings: return "gearshape.2.fill"
        case .profile:  return "person.fill"
        }
    }

    var label: String {
        switch self {
        case .home:     return "Home"
        case .chat:     return "Chat"
        case .settings: return "Settings"
        case .profile:  return "Profile"
        }
    }
}

// MARK: - Custom Glass Tab Bar
struct AppTabBar: View {

    @Binding var selectedTab: AppTab

    // Burgundy active color matching darkRed gradient mid-stop
    private let activeColor = Color(red: 122/255, green: 23/255, blue: 48/255)

    var body: some View {

        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.rawValue) { tab in
                Spacer()
                tabItem(tab)
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background {
            // iOS 26-style liquid glass capsule
            ZStack {
                // Base frosted glass
                Capsule()
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)

                // Subtle inner glow tint
                Capsule()
                    .fill(Color.white.opacity(0.04))

                // Top highlight line (glass rim effect)
                Capsule()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.25),
                                Color.white.opacity(0.05),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 0.8
                    )
            }
        }
        .shadow(color: Color.black.opacity(0.3), radius: 24, x: 0, y: 8)
        .padding(.horizontal, 24)
    }

    @ViewBuilder
    private func tabItem(_ tab: AppTab) -> some View {
        let isSelected = selectedTab == tab

        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 5) {
                ZStack {
                    // Pill highlight behind selected icon
                    if isSelected {
                        Capsule()
                            .fill(activeColor.opacity(0.18))
                            .frame(width: 52, height: 32)
                            .transition(.scale.combined(with: .opacity))
                    }

                    Image(systemName: tab.icon)
                        .font(.system(size: 20, weight: isSelected ? .bold : .regular))
                        .foregroundStyle(
                            isSelected
                                ? AnyShapeStyle(
                                    LinearGradient(
                                        stops: [
                                            .init(color: Color(red: 181/255, green: 72/255, blue: 101/255), location: 0),
                                            .init(color: Color(red: 122/255, green: 23/255, blue: 48/255), location: 0.5),
                                            .init(color: Color(red: 74/255, green: 11/255, blue: 29/255), location: 1)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                : AnyShapeStyle(Color.white.opacity(0.45))
                        )
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                }
                .frame(height: 32)

                Text(tab.label)
                    .font(.system(size: 10, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(
                        isSelected
                            ? AnyShapeStyle(
                                LinearGradient(
                                    stops: [
                                        .init(color: Color(red: 181/255, green: 72/255, blue: 101/255), location: 0),
                                        .init(color: Color(red: 122/255, green: 23/255, blue: 48/255), location: 1)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            : AnyShapeStyle(Color.white.opacity(0.35))
                    )
            }
            .frame(minWidth: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        LinearGradient(
            colors: [Color(red: 0.08, green: 0.05, blue: 0.1), Color.black],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

        VStack {
            Spacer()
            AppTabBar(selectedTab: .constant(.home))
                .padding(.bottom, 24)
        }
    }
}
