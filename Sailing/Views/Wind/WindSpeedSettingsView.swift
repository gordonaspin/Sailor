//
//  WindSpeedSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/19/25.
//

import SwiftUI


struct WindSpeedSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var speedUnits: String
    let shortUnits: [String]
    let longUnits: [String]
    @Binding var colorIndex: Int

    var body: some View {
        NavigationView {
            Form {
                Picker("Units", selection: $speedUnits) {
                    ForEach(0..<shortUnits.count, id: \.self) { i in
                        Text(longUnits[i]).tag(shortUnits[i])
                    }
                }
                .pickerStyle(InlinePickerStyle())
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Wind Speed")
            .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = WindSpeedSetttings.shared
        var body: some View {
            WindSpeedSettingsView(
                speedUnits: settings.$speedUnits,
                shortUnits: settings.units,
                longUnits:  settings.longUnits,
                colorIndex: $settings.colorIndex
            )
        }
    }
    return Preview()

}
