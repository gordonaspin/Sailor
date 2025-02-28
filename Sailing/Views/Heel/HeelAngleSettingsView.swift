//
//  HeelAngleSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI

struct HeelAngleSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var colorIndex: Int
    @Binding var optimumHeelColorIndex: Int
    @Binding var optimumHeelAngle: Int
    @Binding var optimumHeelAngleTolerance: Int
    @Binding var speakHeelAlarms: Bool
    @Binding var underHeelAlarm: String
    @Binding var overHeelAlarm: String
    @Binding var heelAngleWindwardLeeward: Bool
    var optimumHeelAngles: [Int]
    var optimumHeelAngleTolerances: [Int]
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Heel Angle Display")) {
                    Toggle("Display Windward / Leeward", isOn: $heelAngleWindwardLeeward)
                }
                Section(header: Text("Optimum Heel Angle")) {
                    Stepper(value: $optimumHeelAngle, in: 0...25) {
                        Text("\(optimumHeelAngle) degrees")
                    }
                }
                Section(header: Text("Optimum Heel Angle Tolerance")) {
                    Stepper(value: $optimumHeelAngleTolerance, in: 1...5) {
                        Text("+/- \(optimumHeelAngleTolerance) degree\(optimumHeelAngleTolerance > 1 ? "s" : "")")
                    }
                }
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
                optimumHeelAngleTolerance: $settings.optimumHeelAngleTolerance,
                speakHeelAlarms: $settings.speakHeelAlarms,
                underHeelAlarm: $settings.underHeelAlarm,
                overHeelAlarm: $settings.overHeelAlarm,
                heelAngleWindwardLeeward: $settings.heelAngleWindwardLeeward,
                optimumHeelAngles: settings.optimumHeelAngles,
                optimumHeelAngleTolerances: settings.optimumHeelAngleTolerances
            )
            
        }
    }
    return Preview()
}
