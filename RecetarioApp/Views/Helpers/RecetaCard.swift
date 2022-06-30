//
//  RecetaCard.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 12/06/22.
//

import SwiftUI

struct RecetaCard: View {
    var recetario: Recetario
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            recetario.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(alignment: .bottom, content: {
                    Text(recetario.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                        .frame(maxWidth: 140)
                        .padding()
                })
        }
        .frame(width: 180, height: 200, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: colorScheme == .light ? Color.black.opacity(0.3) : Color.white.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

struct RecetaCard_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            RecetaCard(recetario: ModelData().recetas[3]).preferredColorScheme($0)
        }
    }
}
