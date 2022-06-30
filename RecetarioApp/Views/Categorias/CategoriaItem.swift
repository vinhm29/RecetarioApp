//
//  CategoriaItem.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct CategoriaItem: View {
    var recetario: Recetario
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            recetario.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 195, height: 155)
                .cornerRadius(20)
            Text(recetario.name)
                .foregroundColor(.primary)
                .font(.caption)
                .padding(.top, 10)
        }
        .padding()
        .shadow(color: colorScheme == .light ? Color.black.opacity(0.3) : Color.white.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

struct CategoriaItem_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            CategoriaItem(recetario: ModelData().recetas[0]).preferredColorScheme($0)
        }
    }
}
