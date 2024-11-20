//
//  EmptyContentView.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import SwiftUI

///This is a struct representing a empty post/content view
struct EmptyContentView: View {
    
    var title: String
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.title2)
        }
    }
}

#Preview {
    EmptyContentView(title: "No cocktail availale")
}
