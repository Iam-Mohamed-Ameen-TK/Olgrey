//
//  ChatViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

@Observable
final class ChatViewModel {
    
    // Mock Messages
    var messages: [ChatMessage] = [
        ChatMessage(text: "Hey! Are we still on for coffee later?", isCurrentUser: false, showAvatar: true, status: nil),
        ChatMessage(text: "Yes, definitely! What time works for you?", isCurrentUser: true, showAvatar: false, status: "DELIVERED"),
        ChatMessage(text: "How about 3 PM at the usual spot?", isCurrentUser: false, showAvatar: true, status: nil),
        ChatMessage(text: "Perfect, see you then!", isCurrentUser: true, showAvatar: false, status: nil)
    ]
    
}
