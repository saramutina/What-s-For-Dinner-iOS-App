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
    
    @State var isPresenting: Bool = false
    @State var newRecipe = Recipe()
    
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
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            })
        })
        .sheet(isPresented: $isPresenting, content: {
            NavigationView {
                ModifyRecipeView(recipe: $newRecipe)
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction, content: {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        })
                        ToolbarItem(placement: .confirmationAction, content: {
                            if newRecipe.isVaid {
                                Button("Add") {
                                    recipeData.add(newRecipe)
                                    isPresenting = false
                                }
                            }
                        })
                    })
                    .navigationTitle("Add a New Recipe")
            }
        })
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
