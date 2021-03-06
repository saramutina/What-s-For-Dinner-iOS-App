//
//  ModifyIngerdientsView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 01.05.2022.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible, Codable {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>,
         createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("buttonColor") private var buttonColor = AppColor.button
    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add \(Component.singularName().capitalized)")
            
            if components.isEmpty {
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                HStack {
                    Text(Component.pluralName().capitalized)
                        .font(.title)
                        .padding()
                    Spacer()
                    EditButton()
                        .padding()
                }
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        // destination for link:
                        let editComponentView = DestinationView(component: $components[index]) { _ in return }
                            .navigationTitle("Edit \(Component.singularName().capitalized)")
                        // text + link to edit each component:
                        NavigationLink(component.description, destination: editComponentView)
                    }
                    .onDelete {
                        components.remove(atOffsets: $0)
                    }
                    .onMove { indices, newOffset in
                        components.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())", destination: addComponentView)
                        .listRowBackground(buttonColor)
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
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
        }
        NavigationView {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $emptyIngredients)
        }
    }
}
