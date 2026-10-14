//
//  CategoriaRow.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct CategoriaRow: View {
    var categoriaName: String
    var items: [Recetario]
    
    private var formattedTitle: String {
        switch categoriaName {
        case "Desayuno": return "Desayunos"
        case "Almuerzo": return "Almuerzos"
        case "Cena": return "Cenas"
        case "Especeria": return "Especería"
        default: return categoriaName.hasSuffix("s") ? categoriaName : categoriaName + "s"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(formattedTitle)
                .font(.headline)
                .bold()
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 2) {
                    ForEach(items) { recetario in
                        NavigationLink(destination: RecetarioDetail(recetario: recetario)) {
                            CategoriaItem(recetario: recetario)
                        }
                    }
                }
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    let model = ModelData()
    return Group {
        if let first = model.recetas.first {
            CategoriaRow(
                categoriaName: first.category.rawValue,
                items: Array(model.recetas.prefix(4))
            )
        }
    }
}
