//
//  SpeedUnitsPickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct SpeedUnitsPickerView: View {
    @Binding var selectedUnits: String
    let items: [String]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Picker("Units", selection: $selectedUnits) {
                    ForEach(items, id: \.self) { item in
                        Text(item).tag(item)
                    }
                }
                .pickerStyle(InlinePickerStyle())
            }
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationTitle("Choose units")
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var selectedUnits: String = ""

        private var settings = SpeedViewSettings.shared
        var body: some View {
            SpeedUnitsPickerView(selectedUnits: $selectedUnits, items: settings._units)
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
    
    ()
}
