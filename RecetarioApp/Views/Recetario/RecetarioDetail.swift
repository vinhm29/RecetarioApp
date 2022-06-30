//
//  RecetarioDetail.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct RecetarioDetail: View {
    @EnvironmentObject var modelData: ModelData
    var recetario: Recetario
    
    var recetarioIndex: Int {
        modelData.recetas.firstIndex(where: { $0.id == recetario.id })!
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            RectangleImage(image: recetario.image)
                
            VStack(alignment: .leading) {
                HStack {
                    Text(recetario.name)
                        .font(.title)
                        .foregroundColor(.primary)
                        .bold()
                    Spacer()
                    FavoriteButton(isSet: $modelData.recetas[recetarioIndex].isFavorite)
                }
                .padding([.trailing, .leading])
                
                HStack {
                    Text(recetario.porcion)
                    Spacer()
                    Text(recetario.category.rawValue)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding([.trailing, .leading])
                    
                Divider()
                    
                Text("Ingredientes")
                    .font(.title2)
                    .bold()
                    .padding()
                Spacer()
                Text(recetario.ingredientes)
                    .lineSpacing(8.0)
                    .padding([.trailing, .leading])
                    
                Divider()
                    
                Text("Preparación")
                    .font(.title2)
                    .bold()
                    .padding()
                Spacer()
                Text(recetario.preparacion)
                    .lineSpacing(8.0)
                    .padding([.trailing, .leading])
            }
            .padding()
        }
        //.navigationTitle(recetario.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecetarioDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        RecetarioDetail(recetario: ModelData().recetas[0])
            .environmentObject(modelData)
.previewInterfaceOrientation(.portrait)
    }
}
