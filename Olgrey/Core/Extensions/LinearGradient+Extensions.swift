//
//  LinearGradient+Extensions.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

extension LinearGradient {
    
    static var beigeGold: LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 255/255, green: 249/255, blue: 242/255), location: 0.0),
                Gradient.Stop(color: Color(red: 244/255, green: 231/255, blue: 213/255), location: 0.35),
                Gradient.Stop(color: Color(red: 232/255, green: 215/255, blue: 190/255), location: 0.70),
                Gradient.Stop(color: Color(red: 220/255, green: 197/255, blue: 168/255), location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static var darkRed: LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 181/255, green: 72/255, blue: 101/255), location: 0.0),
                Gradient.Stop(color: Color(red: 122/255, green: 23/255, blue: 48/255), location: 0.40),
                Gradient.Stop(color: Color(red: 92/255, green: 16/255, blue: 36/255), location: 0.75),
                Gradient.Stop(color: Color(red: 74/255, green: 11/255, blue: 29/255), location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Preview

struct LinearGradient_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient.beigeGold)
                .frame(height: 180)
                .overlay(
                    Text("Beige Gold")
                        .font(.headline)
                        .foregroundColor(.black)
                )

            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient.darkRed)
                .frame(height: 180)
                .overlay(
                    Text("Dark Red")
                        .font(.headline)
                        .foregroundColor(.white)
                )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
