//
//  RecetarioRow.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct RecetarioRow: View {
    var recetario: Recetario
    
    var body: some View {
        HStack {
            recetario.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 4))
                .shadow(radius: 7)
            
            VStack(alignment: .leading) {
                Text(recetario.name)
                    .font(.title3)
                    .foregroundStyle(.primary)
                Text(recetario.porcion)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.leading, 7)
            
            Spacer()
            
            if recetario.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("BG"))
        }
    }
}

#Preview {
    let model = ModelData()
    return Group {
        if model.recetas.count >= 2 {
            RecetarioRow(recetario: model.recetas[0])
            RecetarioRow(recetario: model.recetas[1])
        }
    }
}
