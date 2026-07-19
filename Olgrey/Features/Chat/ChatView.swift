//
//  ChatView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Inject the ViewModel
    @State private var viewModel = ChatViewModel()

    // Colors matching the reference
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
    private let receivedBg = Color(red: 253/255, green: 248/255, blue: 245/255)

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                bgGradient.ignoresSafeArea()

                VStack(spacing: 0) {
                    
                    // Custom Navigation Bar
                    navBar
                    
                    Divider()
                        .background(goldText.opacity(0.3))
                        .padding(.bottom, 20)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            
                            // Timestamp Pill
                            Text("TODAY 2:42 PM")
                                .font(.system(size: 11))
                                .foregroundColor(goldText)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .stroke(goldText.opacity(0.3), lineWidth: 1)
                                        .background(Capsule().fill(Color.white.opacity(0.1)))
                                )
                                .padding(.bottom, 10)
                                .padding(.top, 20)

                            // Messages List
                            ForEach(viewModel.messages) { message in
                                MessageBubble(
                                    message: message,
                                    burgundy: burgundy,
                                    goldText: goldText,
                                    receivedBg: receivedBg
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Extra padding at the bottom for the tab bar/safe area
                        Spacer().frame(height: 120)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Nav Bar
    private var navBar: some View {
        ZStack {
            // Center Profile Info
            VStack(spacing: 2) {
                Text("Alex Johnson")
                    .font(.custom("Georgia", size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(burgundy)
                
                Text("ACTIVE NOW")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .foregroundColor(goldText)
            }
            
            HStack(alignment: .center) {
                // Back Button
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                        Text("Messages")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(goldText)
                }
                
                Spacer()
                
                // Avatar
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .foregroundColor(burgundy.opacity(0.8))
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(Color.clear) // Transparent nav bar
    }
}

// MARK: - Preview
#Preview {
    ChatView()
}
