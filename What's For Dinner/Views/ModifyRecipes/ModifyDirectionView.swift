//
//  ModifyDirectionView.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 04.05.2022.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>,
         createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Direction", text: $direction.description)
                .listRowBackground(AppColor.background)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(AppColor.background)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .listRowBackground(AppColor.backgroundDarker)
        }
        .foregroundColor(AppColor.foreground)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var testDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
        ModifyDirectionView(component: $testDirection) {
            direction in
            print(direction)
        }
    }
}
