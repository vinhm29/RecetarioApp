//
//  CategoriaHome.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct CategoriaHome: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                if !modelData.features.isEmpty {
                    PageView(pages: modelData.features.map { DestacadoCard(recetario: $0) })
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .padding()
                }
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    Divider()
                    CategoriaRow(categoriaName: key, items: modelData.categories[key] ?? [])
                }
            }
            .navigationTitle("Destacados")
        }
    }
}

#Preview {
    CategoriaHome()
        .environment(ModelData())
}
