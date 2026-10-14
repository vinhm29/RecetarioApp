//
//  CategoriaItem.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct CategoriaItem: View {
    var recetario: Recetario
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            recetario.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 195, height: 155)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            Text(recetario.name)
                .foregroundStyle(.primary)
                .font(.caption)
                .padding(.top, 10)
        }
        .padding()
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
        if let first = model.recetas.first {
            CategoriaItem(recetario: first)
        }
    }
}
