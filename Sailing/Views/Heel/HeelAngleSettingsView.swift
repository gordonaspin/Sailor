//
//  HeelAngleSettingsView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI

struct HeelAngleSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var colorIndex: Int
    @Binding var optimumHeelColorIndex: Int
    @Binding var optimumHeelAngle: Int
    @Binding var speakHeelAlarms: Bool
    @Binding var underHeelAlarm: String
    @Binding var overHeelAlarm: String
    var optimumHeelAngles: [Int]
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Optimum Heel Angle",
                       selection: $optimumHeelAngle,
                       content: {
                    ForEach(optimumHeelAngles, id: \.self) { number in
                        Text("\(number) degrees").tag(number)
                    }
                })
                .pickerStyle(.inline)
                
                Section(header: Text("Heel Angle Alarms")) {
                    Toggle("Speak Heel Alarms", isOn: $speakHeelAlarms)
                    LabeledContent {
                        TextField("Under Heel", text: $underHeelAlarm)
                            .lineLimit(2)
                    } label: {
                        Text("Under heel alarm:")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    LabeledContent {
                        TextField("Over Heel", text: $overHeelAlarm)
                            .lineLimit(2)
                    } label: {
                        Text("Over heel alarm:")
                    }
                }
                ColorPickerView(title: "Heel Color", selectedColor: $colorIndex)
                ColorPickerView(title: "Optimum Heel Color", selectedColor: $optimumHeelColorIndex)
            }
            .navigationTitle("Heel")
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
        @StateObject private var settings = HeelAngleSettings()
        var body: some View {
            HeelAngleSettingsView(
                colorIndex: $settings.colorIndex,
                optimumHeelColorIndex: $settings.optimumHeelColorIndex,
                optimumHeelAngle: $settings.optimumHeelAngle,
                speakHeelAlarms: $settings.speakHeelAlarms,
                underHeelAlarm: $settings.underHeelAlarm,
                overHeelAlarm: $settings.overHeelAlarm,
                optimumHeelAngles: settings.optimumHeelAngles
            )
            
        }
    }
    return Preview()
}
