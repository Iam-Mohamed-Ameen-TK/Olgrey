//
//  MessageBubble.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

// MARK: - Message Bubble
struct MessageBubble: View {
    let message: ChatModel
    let burgundy: Color
    let goldText: Color
    let receivedBg: Color
    
    var body: some View {
        VStack(alignment: message.isCurrentUser ? .trailing : .leading, spacing: 4) {
            HStack(alignment: .bottom, spacing: 12) {
                
                if !message.isCurrentUser {
                    // Avatar for received messages
                    if message.showAvatar {
                        Image("alex_avatar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(color: .black.opacity(0.05), radius: 2, y: 2)
                    } else {
                        Spacer().frame(width: 32) // Keep alignment if no avatar
                    }
                } else {
                    Spacer(minLength: 50)
                }
                
                // Text Bubble
                Text(message.text)
                    .font(.system(size: 15))
                    .foregroundColor(message.isCurrentUser ? .white : .black.opacity(0.85))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(message.isCurrentUser ? burgundy : receivedBg)
                    .clipShape(
                        BubbleShape(isCurrentUser: message.isCurrentUser)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 3)
                
                if !message.isCurrentUser {
                    Spacer(minLength: 50)
                }
            }
            
            // Status Text (e.g. DELIVERED)
            if let status = message.status, message.isCurrentUser {
                Text(status)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(goldText)
                    .padding(.trailing, 4)
            }
        }
    }
}
