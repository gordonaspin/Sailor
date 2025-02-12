//
//  ApparentWindAngleSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 2/11/25.
//

import SwiftUI

struct ApparentWindAngleSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var colorIndex: Int

    var body: some View {
        NavigationView {
            Form {
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Apparent Wind Angle")
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
        @StateObject private var settings = ApparentWindAngleSettings.shared
        var body: some View {
            ApparentWindAngleSettingsView(colorIndex: $settings.colorIndex)
        }
    }
    return Preview()
}
