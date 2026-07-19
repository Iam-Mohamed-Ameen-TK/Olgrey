//
//  SettingsView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct SettingsView: View {
    
    // Colours matching the app's aesthetic
    private let bgGradient = LinearGradient(
        colors: [
            Color(red: 252/255, green: 245/255, blue: 238/255), // Light beige top
            Color(red: 230/255, green: 214/255, blue: 204/255)  // Darker beige bottom
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    private let burgundy = Color(red: 59/255, green: 8/255, blue: 17/255)
    private let goldText = Color(red: 181/255, green: 147/255, blue: 111/255)
    private let cardBg = Color(red: 253/255, green: 248/255, blue: 245/255)
    
    var body: some View {
        ZStack {
            // Background
            bgGradient.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Top Navigation
                navBar
                
                Divider()
                    .background(goldText.opacity(0.3))
                    .padding(.bottom, 20)
                
                // MARK: - Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Account Section
                        SettingsSection(title: "ACCOUNT") {
                            SettingsRow(icon: "person.crop.circle", title: "Personal Information", color: burgundy, goldText: goldText)
                            SettingsRow(icon: "lock.shield", title: "Security & Privacy", color: burgundy, goldText: goldText)
                            SettingsRow(icon: "bell.badge", title: "Notifications", color: burgundy, goldText: goldText)
                        }
                        
                        // Preferences Section
                        SettingsSection(title: "PREFERENCES") {
                            SettingsRow(icon: "globe", title: "Language", value: "English", color: burgundy, goldText: goldText)
                            SettingsRow(icon: "moon.fill", title: "Dark Mode", hasToggle: true, toggleState: false, color: burgundy, goldText: goldText)
                        }
                        
                        // Support Section
                        SettingsSection(title: "SUPPORT") {
                            SettingsRow(icon: "questionmark.circle", title: "Help Center", color: burgundy, goldText: goldText)
                            SettingsRow(icon: "doc.text", title: "Terms of Service", color: burgundy, goldText: goldText)
                        }
                        
                        // Logout Button
                        Button(action: {
                            // Logout action
                        }) {
                            Text("Log Out")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(burgundy)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: burgundy.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, 10)
                        
                        Spacer().frame(height: 120) // Tab bar padding
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    // MARK: - Nav Bar
    private var navBar: some View {
        HStack {
            Spacer()
            
            // Gold Title (Not Burgundy as requested)
            Text("Settings")
                .font(.custom("Georgia", size: 22))
                .fontWeight(.bold)
                .foregroundColor(goldText) // Using gold instead of burgundy
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(Color.clear)
    }
}

// MARK: - Helper Views

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .tracking(1.5)
                .foregroundColor(Color(red: 181/255, green: 147/255, blue: 111/255)) // goldText
                .padding(.leading, 4)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color(red: 253/255, green: 248/255, blue: 245/255)) // cardBg
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var value: String? = nil
    var hasToggle: Bool = false
    @State var toggleState: Bool = false
    let color: Color
    let goldText: Color
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.08))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(color)
            }
            
            // Title
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(color)
            
            Spacer()
            
            // Value or Toggle or Chevron
            if hasToggle {
                Toggle("", isOn: $toggleState)
                    .tint(color)
                    .labelsHidden()
            } else if let value = value {
                Text(value)
                    .font(.system(size: 14))
                    .foregroundColor(goldText)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(goldText.opacity(0.6))
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(goldText.opacity(0.6))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(goldText.opacity(0.15)),
            alignment: .bottom
        )
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
