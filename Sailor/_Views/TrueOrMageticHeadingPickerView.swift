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

    var body: some View {
        NavigationView {
            Form {
                Picker("Heading", selection: $trueNorth) {
                    Text("True ").tag(true)
                    Text(.init("Magnetic ")).tag(false)
                }
                .pickerStyle(InlinePickerStyle())
            }
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
            TrueOrMagneticHeadingPickerView(trueNorth: $settings.trueNorth)
                .preferredColorScheme(.dark)
        }
    }
    return Preview()

}
