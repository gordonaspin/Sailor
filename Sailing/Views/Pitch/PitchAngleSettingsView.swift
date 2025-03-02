//
//  PitchAngleSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/13/25.
//

import SwiftUI

struct PitchAngleSettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var colorIndex: Int
    
    var body: some View {
        NavigationView {
            Form {
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Pitch")
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
        @StateObject private var settings = PitchAngleSettings.shared
        var body: some View {
            PitchAngleSettingsView(colorIndex: $settings.colorIndex)
        }
    }
    return Preview()
    
}
