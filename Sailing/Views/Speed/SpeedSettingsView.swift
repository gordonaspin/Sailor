//
//  SpeedSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI

struct SpeedSettingsView: View {
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
                    //ForEach(items, id: \.self) { item in
                    //    Text(item).tag(item)
                    //}
                }
                .pickerStyle(InlinePickerStyle())
                ColorPickerView(
                    title: "Color",
                    selectedColor: $colorIndex
                )
            }
            .navigationTitle("Speed")
            .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = SpeedSetttings.shared
        var body: some View {
            SpeedSettingsView(
                speedUnits: settings.$speedUnits,
                shortUnits: settings.units,
                longUnits: settings.longUnits,
                colorIndex: $settings.colorIndex
            )
        }
    }
    return Preview()
}
