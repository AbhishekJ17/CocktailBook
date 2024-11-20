//
//  ParseServiceStub.swift
//  CocktailBookTests
//
//  Created by Admin on 20/11/24.
//

import Foundation
@testable import CocktailBook

class ParseServiceStub: ParserServiceProtocol {
    var parseDataResult: Result<[Cocktail], CocktailsAPIError>?

    func parse<T>(data: Data) throws -> [T] where T : Decodable {
        guard let result = parseDataResult else {
            throw CocktailsAPIError.parsingFailed
        }
        
        switch result {
        case .success(let posts):
            return posts as! [T]
        case .failure(let error):
            throw error
        }
    }
}

