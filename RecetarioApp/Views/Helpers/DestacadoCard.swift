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
        recetario.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(TextOverlay(recetario: recetario))
    }
}

struct TextOverlay: View {
    var recetario: Recetario
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(gradient)
            VStack(alignment: .leading) {
                Text(recetario.name)
                    .font(.title)
                    .bold()
                Text(recetario.porcion)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct DestacadoCard_Previews: PreviewProvider {
    static var previews: some View {
        DestacadoCard(recetario: ModelData().features[0])
    }
}
