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
    @Binding var temperatureCelcius: Bool
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
                Section(header: Text("Temperature")) {
                    Toggle("Temperature in Celcius", isOn: $temperatureCelcius)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
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
                temperatureCelcius: settings.$temperatureCelcius,
                shortUnits: settings.units,
                longUnits:  settings.longUnits,
                colorIndex: $settings.colorIndex
            )
        }
    }
    return Preview()

}
