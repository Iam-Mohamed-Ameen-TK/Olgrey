//
//  SocialLoginButton.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

enum SocialLoginType {
    case phone
    case google
    case apple

    var icon: String {
        switch self {
        case .phone:  return "phone.fill"
        case .google: return "google"   // Asset image
        case .apple:  return "apple.logo"
        }
    }

    var usesSystemImage: Bool {
        switch self {
        case .google: return false
        default:      return true
        }
    }

    var label: String {
        switch self {
        case .phone:  return "Phone"
        case .google: return "Google"
        case .apple:  return "Apple"
        }
    }
}

struct SocialLoginButton: View {

    let type: SocialLoginType
    var action: () -> Void = {}

    var body: some View {

        Button(action: action) {

            VStack(spacing: 8) {

                ZStack {

                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 62, height: 62)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    if type.usesSystemImage {

                        Image(systemName: type.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .foregroundColor(.white)

                    } else {

                        Image(type.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                    }
                }

                Text(type.label)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white.opacity(0.65))
            }
        }
    }
}
