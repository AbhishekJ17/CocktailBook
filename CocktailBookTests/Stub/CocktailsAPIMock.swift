//
//  CocktailsAPIMock.swift
//  CocktailBookTests
//
//  Created by Admin on 20/11/24.
//

import Foundation
import Combine
@testable import CocktailBook

class CocktailsAPIMock: CocktailsAPI {
    var cocktailsPublisher: AnyPublisher<Data, CocktailBook.CocktailsAPIError>?
    var fetchCocktailsResult: Result<Data, CocktailsAPIError>?
    
    func fetchCocktails(_ completion: @escaping (Result<Data, CocktailsAPIError>) -> Void) {
        if let result = fetchCocktailsResult {
            completion(result)
        }
    }
}

