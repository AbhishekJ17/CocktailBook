//
//  ParserService.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import Foundation

///This is a protocol for post list fetching
protocol ParserServiceProtocol {
    ///Fetches post list from APIController
    /// - Parameter url: The apiController to fetch posts
    /// - Returns: The fetched post, or error, if an error occurs
    func parse<T: Decodable>(data: Data) throws -> [T]
}

final class ParserService: ParserServiceProtocol {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func parse<T: Decodable>(data: Data) throws -> [T] {
        do {
            let result = try decoder.decode([T].self, from: data)
            return result
        } catch  {
            throw CocktailsAPIError.parsingFailed
        }
    }
}


