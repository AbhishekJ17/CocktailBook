//
//  CocktailDetailView.swift
//  CocktailBook
//
//  Created by Admin on 20/11/24.
//

import SwiftUI

struct CocktailDetailView: View {
    
    let cocktailDetail: Cocktail
    
    init(cocktailDetail: Cocktail) {
        self.cocktailDetail = cocktailDetail
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 13) {
                    
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "clock")
                        Text("\(cocktailDetail.preparationMinutes) minutes")
                    }
                    .padding(.leading, 16)
                    
                    Image(cocktailDetail.imageName, bundle: nil)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(cocktailDetail.longDescription)
                        
                        ForEach(cocktailDetail.ingredients,
                                id: \.self) { ingredient in
                            VStack(alignment: .leading) {
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: "arrowtriangle.right.fill")
                                    Text(ingredient)
                                }
                            }
                        }
                    }
                    .padding(.all, 16)
                }
            }
            .navigationTitle(cocktailDetail.name)
        }
    }
}

#Preview {
   
    return CocktailDetailView(cocktailDetail: cockdetail1)
}

let cockdetail1 = Cocktail(id: "1",
                           name: "Piña colada",
                           type: "alcoholic",
                           shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.",
                           longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.",
                           preparationMinutes: 7,
                           imageName: "pinacolada",
                           ingredients: [
                            "4 oz rum",
                            "3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)",
                            "2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)",
                            "1 ounce freshly squeezed lime juice (optional)",
                            "2 cups ice",
                            "Fresh pineapple, for garnish"])

let cockdetail2 = Cocktail(id: "4",
                        name: "Virgin Mixed Berry Caipirinha",
                        type: "non-alcoholic",
                        shortDescription: "The Brazilian caipirinha is a cocktail that’s hard to resist, but this virgin version might just be the perfect thing for you to drink.",
                        longDescription: "A non-alcohol mixed berry Caipirinha is a wonderful mixture of fresh and juicy mixed berries like raspberry, strawberry and blueberry, muddled with lime and mint, bubbling with sweetness. It makes you feel light and refreshes on warm days and it’s dead easy to prepare.",
                        preparationMinutes: 8,
                        imageName: "virginBerryCaipirinha",
                        ingredients: [
                            "300 g fresh mixed berries",
                            "4 Lime cut and halved",
                            "4 tbsp. mint leaves roughly torn",
                            "8 tbsp. light brown soft sugar",
                            "600 ml cream soda",
                            "crushed ice"])

