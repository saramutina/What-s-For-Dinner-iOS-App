//
//  RecipeData.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 20.04.2022.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
