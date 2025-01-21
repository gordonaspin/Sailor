//
//  SpeedSettingsView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI


struct RaceTimerSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var timerStartValue: Int
    var raceTimerValues: [Int]

    var body: some View {
        NavigationStack {
            List {
                Picker("Start Race Timer at",
                       selection: $timerStartValue,
                       content: {
                    ForEach(raceTimerValues, id: \.self) { number in
                        Text("\(number) minute\(number > 1 ? "s": "")").tag(number*60)
                    }
                })
                .pickerStyle(.inline)
                
            }
            .navigationTitle("Race Timer")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

}

#Preview {
    struct Preview: View {
        @StateObject private var settings = RaceTimerSettings.shared
        var body: some View {
            RaceTimerSettingsView(
                timerStartValue: settings.$raceTimer,
                raceTimerValues: settings.raceTimerValues
            )
        }
    }
    return Preview()

}
