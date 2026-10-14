//
//  RectangleImage.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 8/06/22.
//

import SwiftUI

struct RectangleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .frame(maxWidth: 600, maxHeight: 400, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white, lineWidth: 4)
            )
            .shadow(radius: 7)
            .padding()
    }
}

#Preview {
    RectangleImage(image: Image("Lentejitas"))
}
