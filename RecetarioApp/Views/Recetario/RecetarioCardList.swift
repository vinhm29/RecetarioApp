//
//  RecetarioCardList.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 12/06/22.
//

import SwiftUI

struct RecetarioCardList: View {
    @Environment(ModelData.self) private var modelData
    @State private var busqueda = ""
    
    private var filteredRecetas: [Recetario] {
        if busqueda.trimmingCharacters(in: .whitespaces).isEmpty {
            return modelData.recetas
        } else {
            return modelData.recetas.filter {
                $0.name.localizedCaseInsensitiveContains(busqueda)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                    ForEach(filteredRecetas) { receta in
                        NavigationLink(destination: RecetarioDetail(recetario: receta)) {
                            RecetaCard(recetario: receta)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Recetas")
            .searchable(text: $busqueda, prompt: "Buscar recetas")
        }
    }
}

#Preview {
    RecetarioCardList()
        .environment(ModelData())
}
