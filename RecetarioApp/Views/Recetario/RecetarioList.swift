//
//  RecetarioList.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct RecetarioList: View {
    @Environment(ModelData.self) private var modelData
    @State private var showFavoritesOnly = false
    @State private var filter = FilterCategory.Todos
    @State private var busqueda = ""
    
    enum FilterCategory: String, CaseIterable, Identifiable {
        case Todos = "Todos"
        case Desayuno = "Desayuno"
        case Almuerzo = "Almuerzo"
        case Cena = "Cena"
        case Especeria = "Especeria"
        
        var id: FilterCategory { self }
        
        var displayName: String {
            switch self {
            case .Todos: return "Todos"
            case .Desayuno: return "Desayunos"
            case .Almuerzo: return "Almuerzos"
            case .Cena: return "Cenas"
            case .Especeria: return "Especería"
            }
        }
    }
    
    private var filteredRecetas: [Recetario] {
        modelData.recetas.filter { receta in
            (!showFavoritesOnly || receta.isFavorite)
            && (filter == .Todos || filter.rawValue == receta.category.rawValue)
            && (busqueda.trimmingCharacters(in: .whitespaces).isEmpty || receta.name.localizedCaseInsensitiveContains(busqueda))
        }
    }
    
    private var title: String {
        if showFavoritesOnly {
            return "Favoritos"
        }
        return filter == .Todos ? "Recetas" : filter.displayName
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(filteredRecetas) { receta in
                        NavigationLink(destination: RecetarioDetail(recetario: receta)) {
                            RecetarioRow(recetario: receta)
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding()
            }
            .navigationTitle(title)
            .searchable(text: $busqueda, prompt: "Buscar recetas")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Categorías", selection: $filter) {
                            ForEach(FilterCategory.allCases) { categoria in
                                Text(categoria.displayName).tag(categoria)
                            }
                        }
                        .pickerStyle(.inline)
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Solo favoritos", systemImage: "star.fill")
                        }
                    } label: {
                        Label("Filtrar", systemImage: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

#Preview {
    RecetarioList()
        .environment(ModelData())
}
