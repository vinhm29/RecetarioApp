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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoriaName + "s")
                .font(.headline)
                .bold()
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 2) {
                    ForEach(items) { Recetario in
                        NavigationLink(destination: RecetarioDetail(recetario: Recetario)) {
                            CategoriaItem(recetario: Recetario)
                        }
                    }
                }
            }
            .padding(.trailing)
        }
    }
}

struct CategoriaRow_Previews: PreviewProvider {
    static var recetas = ModelData().recetas
    
    static var previews: some View {
        CategoriaRow(
            categoriaName: recetas[0].category.rawValue,
            items: Array(recetas.prefix(4))
        )
    }
}
