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
            .frame(maxWidth: 600, maxHeight: 400, alignment: .center)
            .aspectRatio(3 / 2, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
            .padding()
    }
}

struct RectangleImage_Previews: PreviewProvider {
    static var previews: some View {
        RectangleImage(image: Image("Lentejitas"))
    }
}
