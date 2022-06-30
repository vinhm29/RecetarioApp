//
//  RecetarioRow.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct RecetarioRow: View {
    var recetario: Recetario
    
    // Para aplicar color dinámico según el color de fondo
    //@Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        HStack {
            recetario.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
            
            VStack(alignment: .leading) {
                Text(recetario.name)
                    .font(.title3)
                    .foregroundColor(.primary)
                    //.foregroundColor(colorScheme == .light ? .black : .white)
                Text(recetario.porcion)
                    .font(.subheadline)
                    .foregroundColor(.primary.opacity(0.6))
            }
            .padding(.leading, 7)
            
            Spacer()
            
            if recetario.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("BG"))
        }
    }
}

struct RecetarioRow_Previews: PreviewProvider {
    static var recetas = ModelData().recetas
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            Group {
                RecetarioRow(recetario: recetas[0])
                RecetarioRow(recetario: recetas[1])
            }
            .previewLayout(.fixed(width: 300, height: 70)).preferredColorScheme($0)
        }
    }
}
