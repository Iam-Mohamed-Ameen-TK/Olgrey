//
//  GlassView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct GlassView<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {

        ZStack {

            BlurView(style: .systemUltraThinMaterialDark)
                .opacity(0.6)

            Color.white.opacity(0.05)

            content
                .padding(25)
        }
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.35),
                radius: 25,
                x: 0,
                y: 15)
    }
}

struct BlurView: UIViewRepresentable {

    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {

        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView,
                      context: Context) {

        uiView.effect = UIBlurEffect(style: style)
    }
}

// MARK: - Preview

struct GlassView_Previews: PreviewProvider {

    static var previews: some View {

        ZStack {

            // Background for preview
            LinearGradient(
                gradient: Gradient(colors: [.purple, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            GlassView {

                VStack(spacing: 16) {

                    Text("Olgrey")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Experience premium glassmorphism.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)

                    Button("Get Started") {

                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(12)

                }
            }
            .frame(width: 320)
        }
        .previewDevice("iPhone 14 Pro")
        .preferredColorScheme(.dark)
    }
}
