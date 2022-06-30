//
//  RecetarioAppApp.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import SwiftUI

@main
struct RecetarioAppApp: App {
    @StateObject private var modelData = ModelData()
    @Environment(\.scenePhase) var scenePhase
    
    init() {
        //Aquí se inicializan los FRAMEWORKS que se necesitan
        print("La aplicación se ha lanzado")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("La APP está activa")
            case .background:
                print("La APP está en background")
            case .inactive:
                print("La APP está inactiva")
            @unknown default:
                print("Valor inexperado")
            }
        }
    }
}
