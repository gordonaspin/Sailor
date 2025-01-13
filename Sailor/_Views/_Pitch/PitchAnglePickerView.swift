//
//  PitchAnglePickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/13/25.
//

import SwiftUI

struct PitchAnglePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var colorIndex: Int

    var body: some View {
        NavigationView {
            Form {
                ColorPickerView(title: "Color", selectedColor: $colorIndex)
            }
            .navigationTitle("Pitch")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = PitchAngleViewSettings.shared
        var body: some View {
            PitchAnglePickerView( colorIndex: $settings.colorIndex)
                .preferredColorScheme(.dark)
        }
    }
    return Preview()

}
