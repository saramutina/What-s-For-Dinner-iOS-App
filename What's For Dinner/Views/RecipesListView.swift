//
//  ContentView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 17.04.2022.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject private var recipeData: RecipeData
    let category: MainInformation.Category
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink("\(emoji) \(recipe.mainInformation.name)",
                               destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .listRowSeparatorTint(listTextColor)
            .foregroundColor(listTextColor)
        }
        .listStyle(.automatic)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}

// Properties:
extension RecipesListView {
    private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    
    private var navigationTitle: String {
        "\(emoji) \(category.rawValue) Recipes"
    }
    
    private var emoji: String {
        recipeData.getEmoji(for: category)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
        
    }
}
