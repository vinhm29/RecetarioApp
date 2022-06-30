//
//  RecetarioList.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct RecetarioList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    @State private var filter = FilterCategory.Todos
    @State private var busqueda = ""
    
    enum FilterCategory: String, CaseIterable, Identifiable {
        case Todos = "Todos"
        case Dessayuno = "Desayuno"
        case Almuerzo = "Almuerzo"
        case Cena = "Cena"
        case Especeria = "Especeria"
        
        var id: FilterCategory { self }
    }
    
    var filteredRecetas: [Recetario] {
        modelData.recetas.filter { Recetario in
            (!showFavoritesOnly || Recetario.isFavorite)
            && (filter == .Todos || filter.rawValue == Recetario.category.rawValue)
        }
    }
    
    var title: String {
        let title = filter == .Todos ? "Recetas" : filter.rawValue + "s"
        return showFavoritesOnly ? "Favoritos" : title
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(busqueda == "" ? filteredRecetas: filteredRecetas.filter{ $0.name.contains(busqueda) }) { Recetario in
                    NavigationLink(destination: RecetarioDetail(recetario: Recetario)) {
                        RecetarioRow(recetario: Recetario)
                    }
                    .padding(5)
                }
            }
            .padding()
            .navigationTitle(title)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker("Categorías", selection: $filter) {
                            ForEach(FilterCategory.allCases) { categoria in
                                Text(categoria.rawValue + "s").tag(categoria)
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Solo favoritos", systemImage: "star.fill")
                        }
                    } label : {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
        }
        .searchable(text: $busqueda)
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(0)
    }
}

struct RecetarioList_Previews: PreviewProvider {
    static var previews: some View {
        RecetarioList()
            .environmentObject(ModelData())
    }
}
