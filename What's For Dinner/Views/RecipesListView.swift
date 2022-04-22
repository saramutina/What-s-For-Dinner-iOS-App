//
//  ContentView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 17.04.2022.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var recipeData = RecipeData()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink("🍽 \(recipe.mainInformation.name)",
                               destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .listRowSeparatorTint(listTextColor)
            .foregroundColor(listTextColor)
        }
        .listStyle(.automatic)
        .navigationTitle(navigationTitle)
    }
}

// Properties:
extension RecipesListView {
    var recipes: [Recipe] {
        recipeData.recipes
    }
    
    var navigationTitle: String {
        "All Recipes"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView()
        }
        
    }
}
