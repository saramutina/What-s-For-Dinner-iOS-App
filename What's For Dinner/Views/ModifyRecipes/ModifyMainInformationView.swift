//
//  ModifyMainInformationView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 01.05.2022.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformaition: MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformaition.name)
                .listRowBackground(AppColor.background)
            TextField("Author", text: $mainInformaition.author)
                .listRowBackground(AppColor.background)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformaition.description)
                    .listRowBackground(AppColor.background)
            }
            Section(header: Text("Category")) {
                Picker("Select category", selection: $mainInformaition.category) {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .listRowBackground(AppColor.background)
            }
        }
        .foregroundColor(AppColor.foreground)
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
