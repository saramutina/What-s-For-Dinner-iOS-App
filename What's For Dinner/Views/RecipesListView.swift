//
//  ContentView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 17.04.2022.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                Text("🍽   \(recipe.mainInformation.name)")
                    .listRowSeparatorTint(Color.yellow)
            }
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
