//
//  BoatHeadingSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct BoatHeadingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var trueNorth: Bool
    @Binding var colorIndex: Int
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("True North", isOn: $trueNorth)
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Boat Heading")
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = BoatHeadingSettings.shared
        var body: some View {
            BoatHeadingSettingsView(
                trueNorth: $settings.trueNorth,
                colorIndex: $settings.colorIndex
            )
        }
    }
    return Preview()
}
