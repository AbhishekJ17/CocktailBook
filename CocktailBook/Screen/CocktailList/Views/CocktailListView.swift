//
//  CocktailListView.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import SwiftUI

struct CocktailListView: View {
    
    @ObservedObject var viewModel: CocktailViewModel
    @State private var navigateToCocktailDetail = false
    @State private var selectedCocktail: Cocktail?
    
    init(viewModel: CocktailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                CocktailFilterView(cocktailType: $viewModel.selectedCocktailType)
                    .onChange(of: viewModel.selectedCocktailType) { newType in
                        viewModel.filterCocktail()
                    }
                
                SeperatorView()
                
                if viewModel.showEmptyScreen() {
                    EmptyContentView(title: viewModel.error)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.filteredCocktailList) { cocktail in
                                VStack(alignment: .leading,
                                       spacing: 5) {
                                    
                                    Text(cocktail.name)
                                        .font(.headline)
                                    
                                    Text(cocktail.shortDescription)
                                        .font(.callout)
                                }
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 10)
                                .onTapGesture {
                                    selectedCocktail = cocktail
                                    navigateToCocktailDetail = true
                                }
                                
                                SeperatorView()
                            }
                        }
                    }
                }
                if viewModel.isLoading {
                    LoaderView()
                }
            }
            .onAppear {
                viewModel.getCocktailList()
            }
            .navigationDestination(isPresented: $navigateToCocktailDetail) {
                if let cocktail = selectedCocktail {
                    CocktailDetailView(cocktailDetail: cocktail)
                }
            }
            .navigationTitle(viewModel.selectedCocktailType.title)
        }
    }
}

#Preview {
    CocktailListScreenBuilder.makeCocktailListView()
}
#Preview {
    CocktailListScreenBuilder.makeCocktailListView()
}
