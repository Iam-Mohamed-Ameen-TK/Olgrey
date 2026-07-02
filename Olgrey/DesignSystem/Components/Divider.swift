//
//  Divider.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct AuthDivider: View {

    var text: String = "or continue with"

    var body: some View {

        HStack {

            Rectangle()
                .fill(LinearGradient.beigeGold.opacity(0.15))
                .frame(height: 1)

            Text(text)
                .font(.footnote)
                .foregroundStyle(LinearGradient.beigeGold)
                .opacity(0.7)

            Rectangle()
                .fill(LinearGradient.beigeGold.opacity(0.15))
                .frame(height: 1)

        }
    }
}


struct AuthDivider_Previews: PreviewProvider {

    static var previews: some View {

        AuthDivider()
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
