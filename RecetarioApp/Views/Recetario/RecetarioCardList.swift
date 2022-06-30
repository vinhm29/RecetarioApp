//
//  RecetarioCardList.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 12/06/22.
//

import SwiftUI

struct RecetarioCardList: View {
    @EnvironmentObject var modelData: ModelData
    var recetario: [Recetario] = ModelData().recetas
    @State private var busqueda = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    /*HStack {
                        Text("\(recetario.count) \(recetario.count > 1 ? "recetas" : "receta")")
                            .font(.headline)
                            .fontWeight(.medium)
                            .opacity(0.7)
                        
                        Spacer()
                    }*/
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                        ForEach(busqueda == "" ? recetario: recetario.filter{ $0.name.contains(busqueda) }) { recetario in
                            NavigationLink(destination: RecetarioDetail(recetario: recetario)) {
                                RecetaCard(recetario: recetario)
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.top)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Recetas")
        }
        .searchable(text: $busqueda)
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(0)
    }
}

struct RecetarioCardList_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        RecetarioCardList()
            .environmentObject(ModelData())
    }
}
