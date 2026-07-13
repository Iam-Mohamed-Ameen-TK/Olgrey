//
//  ChatView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(LinearGradient.beigeGold)
                Text("Chats")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LinearGradient.beigeGold)
            }
        }
    }
}
