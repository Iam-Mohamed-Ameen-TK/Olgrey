//
//  SettingsView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                Image(systemName: "gearshape.2.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(LinearGradient.beigeGold)
                Text("Settings")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LinearGradient.beigeGold)
            }
        }
    }
}
