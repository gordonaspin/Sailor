//
//  SpeedUnitsPickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct SpeedUnitsPickerView: View {
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
            .navigationTitle("Speed")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

}

#Preview {
    struct Preview: View {
        @StateObject private var settings = SpeedViewSettings.shared
        var body: some View {
            SpeedUnitsPickerView(speedUnits: settings.$speedUnits, items: settings._units, colorIndex: $settings.colorIndex)
                .preferredColorScheme(.dark)
        }
    }
    return Preview()

}
