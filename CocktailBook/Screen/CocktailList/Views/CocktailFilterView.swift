//
//  CocktailFilterView.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import SwiftUI

struct CocktailFilterView: View {
    
    @Binding var cocktailType: CocktailType
    
    var body: some View {
        Picker("Select an option", selection: $cocktailType) {
            ForEach(CocktailType.allCases, id: \.self) { cocktail in
                Text(cocktail.rawValue).tag(cocktail)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

#Preview {
    @State var allCocktail: CocktailType = .allCocktail
    return CocktailFilterView(cocktailType: $allCocktail)
}
