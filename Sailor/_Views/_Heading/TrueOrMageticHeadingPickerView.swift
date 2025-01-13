//
//  SpeedUnitsPickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct TrueOrMagneticHeadingPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var trueNorth: Bool
    @Binding var colorIndex: Int

    var body: some View {
        NavigationView {
            Form {
                Picker("Heading", selection: $trueNorth) {
                    Text("True ").tag(true)
                    Text(.init("Magnetic ")).tag(false)
                }
                .pickerStyle(InlinePickerStyle())
                ColorPickerView(title: "Color", selectedColor: $colorIndex)

            }
            .navigationTitle("Heading")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingViewSettings.shared
        var body: some View {
            TrueOrMagneticHeadingPickerView(trueNorth: $settings.trueNorth, colorIndex: $settings.colorIndex)
                .preferredColorScheme(.dark)
        }
    }
    return Preview()

}
