//
//  RecetarioAppApp.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

@main
struct RecetarioAppApp: App {
    @State private var modelData = ModelData()
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        print("La aplicación se ha lanzado")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                print("La APP está activa")
            case .background:
                print("La APP está en background")
            case .inactive:
                print("La APP está inactiva")
            @unknown default:
                print("Valor inesperado")
            }
        }
    }
}
