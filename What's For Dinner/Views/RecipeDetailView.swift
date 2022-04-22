//
//  RecipeDetailView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 21.04.2022.
//

import SwiftUI
import Foundation

struct RecipeDetailView: View {
    let recipe: Recipe
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Autor: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                            .listRowSeparatorTint(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        
                        HStack {
                            Text("\(index + 1). ").bold()
                            Group{
                                Text(" \(direction.isOptional ? "Optional  " : "")")
                                    .italic()
                                    .foregroundColor(Color.purple)
                                +
                                Text(direction.description)
                            }
                        }
                        .foregroundColor(listTextColor)
                        .listRowSeparatorTint(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
            }
        }
        .navigationTitle(recipe.mainInformation.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: recipe)
        }
    }
}
