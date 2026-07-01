//
//  Divider.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct AuthDivider: View {

    var body: some View {

        HStack {

            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 1)

            Text("or continue with")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.7))

            Rectangle()
                .fill(Color.white.opacity(0.15))
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
