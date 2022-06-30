//
//  CategoriaHome.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct CategoriaHome: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                PageView(pages: modelData.features.map { DestacadoCard(recetario: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .padding()
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    Divider()
                    
                    CategoriaRow(categoriaName: key, items: modelData.categories[key]!)
                }
            }
            .navigationTitle("Destacados")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(0)
    }
}

struct CategoriaHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaHome()
            .environmentObject(ModelData())
    }
}
