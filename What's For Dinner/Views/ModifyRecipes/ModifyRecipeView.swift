//
//  ModifyRecipeView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 25.04.2022.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        Button("Fill in the recipe with test data.") {
            recipe.mainInformation = MainInformation(name: "test",
                                                     description: "test",
                                                     author: "test",
                                                     category: .breakfast)
            recipe.directions = [Direction(description: "test",
                                           isOptional: false)]
            recipe.ingredients = [Ingredient(name: "test",
                                             quantity: 1.0,
                                             unit: .none)]
        }
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
