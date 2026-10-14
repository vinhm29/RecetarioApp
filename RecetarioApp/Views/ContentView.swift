//
//  ContentView.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .home
    
    enum Tab {
        case featured
        case list
        case home
    }
    
    var body: some View {
        TabView(selection: $selection) {
            RecetarioCardList()
                .tabItem {
                    Label("Principal", systemImage: "house")
                }
                .tag(Tab.home)
            
            CategoriaHome()
                .tabItem {
                    Label("Destacado", systemImage: "list.bullet")
                }
                .tag(Tab.featured)
            
            RecetarioList()
                .tabItem {
                    Label("Lista", systemImage: "list.bullet.rectangle.portrait")
                }
                .tag(Tab.list)
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
