//
//  SpeedUnitsPickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI

struct HeelAngleLimitsPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var optimumHeelAngle: Int
    @Binding var underHeelAlarm: String
    @Binding var overHeelAlarm: String
    @Binding var colorIndex: Int
    @Binding var optimumHeelColorIndex: Int
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
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeelAngleViewSettings()
        var body: some View {
            HeelAngleLimitsPickerView(  optimumHeelAngle: $settings.optimumHeelAngle,
                                        underHeelAlarm: $settings.underHeelAlarm,
                                        overHeelAlarm: $settings.overHeelAlarm,
                                        colorIndex: $settings.colorIndex,
                                        optimumHeelColorIndex: $settings.optimumHeelColorIndex,
                                        optimumHeelAngles: settings.optimumHeelAngles
                                        )

            }
        }
    return Preview()
}
