//
//  RecipeData.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 20.04.2022.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    var favoriteRecipes: [Recipe] {
        recipes.filter {
            $0.isFavorite
        }
    }
    
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
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        }
        catch {
            fatalError("An error occured while saving recipes: \(error)")
        }
    }
    
    func loadRecipes() {
        guard let data = try? Data(contentsOf: recipesFileURL) else { return }
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
            recipes = savedRecipes
        }
        catch {
            fatalError("An error occured while loading recipes: \(error)")
        }
    }
    
    func deleteRecipe(for viewStyle: RecipesListView.ViewStyle, atOffsets offsets: IndexSet) {
        let filteredIndex = offsets[offsets.startIndex]
        var recipeToDelete: Recipe
        switch viewStyle {
        case .favorites:
            recipeToDelete = favoriteRecipes[filteredIndex]
        case let .singleCategory(category):
            recipeToDelete = recipes(for: category)[filteredIndex]
        }
        guard let indexOfRecipeToDelete = recipes.firstIndex(where: {$0.id == recipeToDelete.id}) else { return }
        recipes.remove(at: indexOfRecipeToDelete)
    }
    
    // file location to store recipes:
    private var recipesFileURL: URL {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                 in: .userDomainMask,
                                                                 appropriateFor: nil,
                                                                 create: true)
            return documentsDirectory.appendingPathComponent("recipeData")
        }
        catch {
            fatalError("An error occured while getting the url: \(error)")
        }
    }
    
}
