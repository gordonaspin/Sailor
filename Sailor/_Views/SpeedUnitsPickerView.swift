//
//  SpeedUnitsPickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct SpeedUnitsPickerView: View {
    @Binding var speedUnits: String
    let items: [String]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Picker("Speed", selection: $speedUnits) {
                    ForEach(items, id: \.self) { item in
                        Text(item).tag(item)
                    }
                }
                .pickerStyle(InlinePickerStyle())
            }
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            //.navigationTitle("Choose units")
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = SpeedViewSettings.shared
        @State private var speedUnits: String = "knots"
        var body: some View {
            //SpeedUnitsPickerView(speedUnits: settings.$speedUnits, items: settings._units)
            SpeedUnitsPickerView(speedUnits: $speedUnits, items: settings._units)
                .preferredColorScheme(.dark)
        }
    }
    return Preview()

}
