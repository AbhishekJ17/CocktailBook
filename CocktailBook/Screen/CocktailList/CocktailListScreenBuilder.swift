//
//  CocktailListScreenBuilder.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import SwiftUI

struct CocktailListScreenBuilder {
    
    static func makeCocktailListView() -> CocktailListView {
        let parser = ParserService()
        let cocktailAPI = FakeCocktailsAPI()
        let viewModel = CocktailViewModel(parserService: parser,
                                          cocktailsAPI: cocktailAPI)
        return CocktailListView(viewModel: viewModel)
    }
}

