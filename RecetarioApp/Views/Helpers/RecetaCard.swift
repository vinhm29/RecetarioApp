//
//  RecetaCard.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 12/06/22.
//

import SwiftUI

struct RecetaCard: View {
    var recetario: Recetario
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            recetario.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(alignment: .bottom) {
                    Text(recetario.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                        .frame(maxWidth: 140)
                        .padding()
                }
        }
        .frame(width: 180, height: 200, alignment: .center)
        .background(
            LinearGradient(
                colors: [Color.gray.opacity(0.3), Color.gray],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(
            color: colorScheme == .light ? .black.opacity(0.3) : .white.opacity(0.3),
            radius: 15,
            x: 0,
            y: 10
        )
    }
}

#Preview {
    let model = ModelData()
    return Group {
        if let receta = model.recetas.first {
            RecetaCard(recetario: receta)
        }
    }
}
