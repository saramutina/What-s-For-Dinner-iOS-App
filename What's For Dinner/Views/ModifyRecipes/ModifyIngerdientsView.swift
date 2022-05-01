//
//  ModifyIngerdientsView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 01.05.2022.
//

import SwiftUI

struct ModifyIngerdientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }.navigationTitle("Add Ingredient")
            
            if ingredients.isEmpty {
                NavigationLink("Add the first ingredient", destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    .listRowBackground(AppColor.background)
                    NavigationLink("Add another ingredient", destination: addIngredientView)
                        .listRowBackground(AppColor.backgroundDarker)
                        .buttonStyle(.plain)
                }
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    @State static var emptyIngredients = [Ingredient]()
    static var previews: some View {
        NavigationView {
            ModifyIngerdientsView(ingredients: $recipe.ingredients)
        }
        NavigationView {
            ModifyIngerdientsView(ingredients: $emptyIngredients)
        }
    }
}
