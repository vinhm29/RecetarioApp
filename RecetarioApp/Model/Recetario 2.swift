//
//  Recetario.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 22/10/21.
//

import Foundation
import SwiftUI

struct Recetario: Hashable, Codable, Identifiable {
    var id : Int
    var name: String
    var porcion: String
    var ingredientes: String
    var preparacion: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case Desayuno = "Desayuno"
        case Almuerzo = "Almuerzo"
        case Cena = "Cena"
        case Especeria
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
}
