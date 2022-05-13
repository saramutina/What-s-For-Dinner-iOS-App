//
//  ModifyMainInformationView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 01.05.2022.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformaition: MainInformation
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("buttonColor") private var buttonColor = AppColor.button
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformaition.name)
                .listRowBackground(listBackgroundColor)
            TextField("Author", text: $mainInformaition.author)
                .listRowBackground(listBackgroundColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformaition.description)
                    .listRowBackground(listBackgroundColor)
            }
            Section(header: Text("Category")) {
                Picker("Select category", selection: $mainInformaition.category) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .listRowBackground(listBackgroundColor)
            }
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var testMainInfo = MainInformation(name: "test",
                                                     description: "test description",
                                                     author: "Jane Doe",
                                                     category: .lunch)
    
    static var previews: some View {
        ModifyMainInformationView(mainInformaition: $testMainInfo)
    }
}
