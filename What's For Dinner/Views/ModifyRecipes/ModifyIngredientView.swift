//
//  ModifyIngredientView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 01.05.2022.
//

import SwiftUI

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Ingredient Name", text: $ingredient.name)
                .listRowBackground(AppColor.background)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                HStack {
                    Text("Quantity")
                    TextField("Quantity",
                              value: $ingredient.quantity,
                              formatter: NumberFormatter.decimal)
                    .keyboardType(.numbersAndPunctuation)
                }
            }
            .listRowBackground(AppColor.background)
            Picker("Unit", selection: $ingredient.unit) {
                ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue).tag(unit)
                }
            }
            .pickerStyle(.menu)
            .listRowBackground(AppColor.background)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(ingredient)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .listRowBackground(AppColor.backgroundDarker)
        }
        .foregroundColor(AppColor.foreground)
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}


struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var testIngredient = Ingredient()
    static var previews: some View {
        ModifyIngredientView(ingredient: $testIngredient) {
            ingredient in
            print(ingredient)
        }
    }
}
