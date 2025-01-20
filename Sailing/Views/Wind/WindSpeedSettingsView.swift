//
//  WindSpeedSettingsView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/19/25.
//

import SwiftUI


struct WindSpeedSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var speedUnits: String
    let items: [String]
    @Binding var colorIndex: Int

    var body: some View {
        NavigationView {
            Form {
                Picker("Units", selection: $speedUnits) {
                    ForEach(items, id: \.self) { item in
                        Text(item).tag(item)
                    }
                }
                .pickerStyle(InlinePickerStyle())
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Wind Speed")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

}

#Preview {
    struct Preview: View {
        @StateObject private var settings = WindSpeedSetttings.shared
        var body: some View {
            WindSpeedSettingsView(speedUnits: settings.$speedUnits, items: settings.units, colorIndex: $settings.colorIndex)
        }
    }
    return Preview()

}
