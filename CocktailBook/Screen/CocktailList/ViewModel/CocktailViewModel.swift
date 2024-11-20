//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import Foundation

enum CocktailType: String, CaseIterable {
    
    case allCocktail = "All"
    case alcoholicCocktails = "Alcoholic"
    case nonAlcoholicCocktails  = "Non-Alcoholic"
    
    var title: String {
        switch self {
        case .allCocktail: return "All Cocktails"
        case .alcoholicCocktails: return "Alcoholic Cocktails"
        case .nonAlcoholicCocktails: return "Non-Alcoholic Cocktails"
        }
    }
    
    var type: String? {
        switch self {
        case .allCocktail: return nil
        case .alcoholicCocktails: return "alcoholic"
        case .nonAlcoholicCocktails: return "non-alcoholic"
        }
    }
}

final class CocktailViewModel: ObservableObject {
    
    private let parserService: ParserServiceProtocol
    private let cocktailsAPI: CocktailsAPI
    var allCocktailList: [CocktailType: [Cocktail]] = [:]
    @Published var filteredCocktailList: [Cocktail] = []
    @Published var error: String = ""
    @Published var isLoading: Bool = true
    @Published var selectedCocktailType: CocktailType = .allCocktail
    
    init(parserService: ParserServiceProtocol,
         cocktailsAPI: CocktailsAPI) {
        self.parserService = parserService
        self.cocktailsAPI = cocktailsAPI
    }
    
    func showEmptyScreen() -> Bool {
        return filteredCocktailList.isEmpty && !(isLoading)
    }
    
    @MainActor
    func getCocktailList() {
        cocktailsAPI.fetchCocktails { result in
            self.isLoading = false
            switch result {
            case .success(let data):
                do {
                    let result: [Cocktail] = try self.parserService.parse(data: data)
                    self.mapCocktails(cocktails: result.sorted(by: >))
                } catch let error {
                    self.error = error.localizedDescription
                }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
    
    func mapCocktails(cocktails: [Cocktail]) {
        allCocktailList[.allCocktail] = cocktails
        
        let alcoholicCocktail = cocktails.filter({ $0.type == CocktailType.alcoholicCocktails.type })
        allCocktailList[.alcoholicCocktails] = alcoholicCocktail
        
        let nonAlcoholicCocktail = cocktails.filter({ $0.type == CocktailType.nonAlcoholicCocktails.type })
        allCocktailList[.nonAlcoholicCocktails] = nonAlcoholicCocktail
        
        filteredCocktailList = allCocktailList[.allCocktail] ?? []
    }
    
    func filterCocktail() {
        filteredCocktailList = allCocktailList[selectedCocktailType] ?? []
    }
    
}

