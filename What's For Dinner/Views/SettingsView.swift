//
//  SettingsView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 13.05.2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var hideOptionalSteps: Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    @AppStorage("buttonColor") private var buttonColor = AppColor.button
    
    var body: some View {
        NavigationView {
            Form {
                ColorPicker("List Background Color", selection: $listBackgroundColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                ColorPicker("Text Color", selection: $listTextColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                ColorPicker("Button Color", selection: $buttonColor)
                    .padding()
                    .listRowBackground(buttonColor)
                Toggle("Hide Optional Steps in Recipes", isOn: $hideOptionalSteps)
                    .padding()
                    .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
