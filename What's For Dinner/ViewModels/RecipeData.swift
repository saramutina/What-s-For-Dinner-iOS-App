//
//  RecipeData.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 20.04.2022.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
    // filter recipes:
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func add(_ recipe: Recipe) {
        if recipe.isVaid {
            recipes.append(recipe)
        }
    }
    
    func getEmoji(for category: MainInformation.Category) -> String {
        switch category {
        case .breakfast:
            return "🥞"
        case .lunch:
            return "🥗"
        case .dinner:
            return "🍲"
        case .dessert:
            return "🧁"
        }
    }
    
}
