//
//  RecetarioDetail.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct RecetarioDetail: View {
    @Environment(ModelData.self) private var modelData
    var recetario: Recetario
    
    private var recetarioIndex: Int? {
        modelData.index(of: recetario)
    }
    
    private var currentReceta: Recetario {
        if let index = recetarioIndex {
            return modelData.recetas[index]
        }
        return recetario
    }
    
    var body: some View {
        @Bindable var bindableModel = modelData
        
        ScrollView(.vertical, showsIndicators: false) {
            RectangleImage(image: currentReceta.image)
                
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(currentReceta.name)
                        .font(.title)
                        .foregroundStyle(.primary)
                        .bold()
                    Spacer()
                    if let index = recetarioIndex {
                        FavoriteButton(isSet: $bindableModel.recetas[index].isFavorite)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text(currentReceta.porcion)
                    Spacer()
                    Text(currentReceta.category.rawValue)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                    
                Divider()
                    
                Text("Ingredientes")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                
                Text(currentReceta.ingredientes)
                    .lineSpacing(8.0)
                    .padding(.horizontal)
                    
                Divider()
                    
                Text("Preparación")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                
                Text(currentReceta.preparacion)
                    .lineSpacing(8.0)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let modelData = ModelData()
    return Group {
        if let first = modelData.recetas.first {
            NavigationStack {
                RecetarioDetail(recetario: first)
                    .environment(modelData)
            }
        }
    }
}
