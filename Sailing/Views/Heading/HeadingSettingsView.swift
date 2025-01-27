//
//  HeadingSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct HeadingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var trueNorth: Bool
    @Binding var colorIndex: Int
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("True North", isOn: $trueNorth)
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Heading")
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
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            HeadingSettingsView(
                trueNorth: $settings.trueNorth,
                colorIndex: $settings.colorIndex
            )
        }
    }
    return Preview()
}
