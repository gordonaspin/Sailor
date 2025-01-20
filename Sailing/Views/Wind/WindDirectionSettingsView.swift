//
//  WindDirectionSettingsView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/19/25.
//

import SwiftUI

struct WindDirectionSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var colorIndex: Int

    var body: some View {
        NavigationView {
            Form {
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Wind Direction")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = WindDirectionSettings.shared
        var body: some View {
            WindDirectionSettingsView( colorIndex: $settings.colorIndex)
        }
    }
    return Preview()
}
