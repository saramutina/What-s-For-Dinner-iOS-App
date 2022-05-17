//
//  ContentView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 17.04.2022.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject private var recipeData: RecipeData
    let viewStyle: ViewStyle
    
    @State var isPresenting: Bool = false
    @State var newRecipe = Recipe()
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("buttonColor") private var buttonColor = AppColor.button
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink("\(recipeData.getEmoji(for: recipe.mainInformation.category)) \(recipe.mainInformation.name)",
                               destination: RecipeDetailView(recipe: binding(for: recipe)))
            }
            .onDelete {
                recipeData.deleteRecipe(for: viewStyle, atOffsets: $0)
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .listStyle(.automatic)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.large)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    newRecipe = Recipe()
                    newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
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
                                    if case .favorites = viewStyle {
                                        newRecipe.isFavorite = true
                                    }
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
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    private var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            return recipeData.recipes(for: category)
        case .favorites:
            return recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return "\(recipeData.getEmoji(for: category)) \(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    }

    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast))
        }
        .environmentObject(RecipeData())
    }
}
