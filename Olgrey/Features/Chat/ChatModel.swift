//
//  ChatMessage.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation

// MARK: - Message Model
struct ChatModel: Identifiable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
    let showAvatar: Bool
    let status: String? // e.g., "DELIVERED"
}
