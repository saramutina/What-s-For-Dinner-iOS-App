//
//  RecipeDetailView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 21.04.2022.
//

import SwiftUI
import Foundation

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @State var isPresenting: Bool = false
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("buttonColor") private var buttonColor = AppColor.button
    
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
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
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Group{
                                    Text(" \(direction.isOptional ? "Optional  " : "")")
                                        .italic()
                                        .foregroundColor(listTextColor.opacity(0.7))
                                    +
                                    Text(direction.description)
                                }
                            }
                            .foregroundColor(listTextColor)
                        }
                    }
                }.listRowBackground(listBackgroundColor)
            }
        }
        .navigationTitle(recipe.mainInformation.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button(action: {
                        recipe.isFavorite.toggle()
                    }, label: {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    })
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                    }
                    .navigationTitle("Edit Recipe")
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: $recipe)
        }
    }
}
