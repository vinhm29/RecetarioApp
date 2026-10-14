//
//  DestacadoCard.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct DestacadoCard: View {
    var recetario: Recetario
    
    var body: some View {
        if let featureImage = recetario.featureImage {
            featureImage
                .resizable()
                .aspectRatio(3 / 2, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(TextOverlay(recetario: recetario))
        } else {
            recetario.image
                .resizable()
                .aspectRatio(3 / 2, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(TextOverlay(recetario: recetario))
        }
    }
}

struct TextOverlay: View {
    var recetario: Recetario
    
    var gradient: LinearGradient {
        LinearGradient(
            colors: [.black.opacity(0.6), .black.opacity(0)],
            startPoint: .bottom,
            endPoint: .center
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(gradient)
            VStack(alignment: .leading) {
                Text(recetario.name)
                    .font(.title)
                    .bold()
                Text(recetario.porcion)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    let model = ModelData()
    return Group {
        if let first = model.features.first {
            DestacadoCard(recetario: first)
        }
    }
}
