//
//  Cocktail.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import Foundation

struct Cocktail: Codable, Identifiable{
    
    var id: String
    var name: String
    var type: String
    var shortDescription: String
    var longDescription: String
    var preparationMinutes: Int
    var imageName: String
    var ingredients: [String]
}

extension Cocktail: Comparable {
    static func < (lhs: Cocktail, rhs: Cocktail) -> Bool {
        return lhs.name > rhs.name
    }
}

