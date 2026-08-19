//
//  ChatListView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct ChatListModel: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let time: String
    let unreadCount: Int
    let isOnline: Bool
}

struct ChatListView: View {
    
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
    
    // Dummy Data
    private let chats: [ChatListModel] = [
        ChatListModel(name: "Alex Johnson", lastMessage: "Perfect, see you then!", time: "2:42 PM", unreadCount: 2, isOnline: true),
        ChatListModel(name: "Sarah Miller", lastMessage: "I'll send the files over shortly.", time: "11:30 AM", unreadCount: 0, isOnline: false),
        ChatListModel(name: "David Chen", lastMessage: "Thanks for the update.", time: "Yesterday", unreadCount: 1, isOnline: true),
        ChatListModel(name: "Emma Watson", lastMessage: "Are we still on for tomorrow?", time: "Monday", unreadCount: 0, isOnline: false)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                bgGradient.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    // MARK: - Top Navigation
                    navBar
                    
                    Divider()
                        .background(goldText.opacity(0.3))
                        .padding(.bottom, 10)
                    
                    // MARK: - Search Bar
                    searchBar
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                    
                    // MARK: - Chat List
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(chats) { chat in
                                NavigationLink(destination: ChatView()) {
                                    chatRow(chat)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer().frame(height: 120) // Bottom padding for Tab Bar
                    }
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var navBar: some View {
        HStack {
            Text("Messages")
                .font(.custom("Georgia", size: 28))
                .fontWeight(.bold)
                .foregroundColor(burgundy)
            
            Spacer()
            
            Button(action: {
                // New Chat Action
            }) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(burgundy)
                    .padding(8)
                    .background(Color.white.opacity(0.3))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 8)
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(goldText.opacity(0.8))
            
            TextField("Search messages...", text: .constant(""))
                .font(.system(size: 15))
                .foregroundColor(burgundy)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(cardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(goldText.opacity(0.2), lineWidth: 1)
        )
    }
    
    private func chatRow(_ chat: ChatListModel) -> some View {
        HStack(spacing: 16) {
            
            // Avatar with Online Indicator
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .foregroundColor(burgundy.opacity(0.7))
                    .background(Color.white)
                    .clipShape(Circle())
                
                if chat.isOnline {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(cardBg, lineWidth: 2))
                        .offset(x: 2, y: 2)
                }
            }
            
            // Name and Last Message
            VStack(alignment: .leading, spacing: 4) {
                Text(chat.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(burgundy)
                
                Text(chat.lastMessage)
                    .font(.system(size: 14))
                    .foregroundColor(goldText)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Time and Unread Badge
            VStack(alignment: .trailing, spacing: 6) {
                Text(chat.time)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(chat.unreadCount > 0 ? burgundy : goldText.opacity(0.8))
                
                if chat.unreadCount > 0 {
                    Text("\(chat.unreadCount)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .background(burgundy)
                        .clipShape(Circle())
                } else {
                    Spacer().frame(height: 20)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(cardBg)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.03), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Preview
#Preview {
    ChatListView()
}
