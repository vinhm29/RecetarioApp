//
//  PageView.swift
//  RecetarioApp
//
//  Created by Vincenzo Tipacti Moran on 23/10/21.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
    }
}

#Preview {
    let model = ModelData()
    return Group {
        if !model.features.isEmpty {
            PageView(pages: model.features.map { DestacadoCard(recetario: $0) })
                .aspectRatio(3 / 2, contentMode: .fit)
        }
    }
}
