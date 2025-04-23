//
//  RaceTimerSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/9/25.
//

import SwiftUI

struct RaceTimerSettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var timerStartValue: Int
    var raceTimerValues: [Int]
    @Binding var speakTimerAlerts: Bool
    @Binding var audibleTimerAlerts: Bool

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Start Race Timer at")) {
                    Stepper(value: $timerStartValue, in: raceTimerValues[0]...raceTimerValues[raceTimerValues.count-1], step:60) {
                        Text("\(timerStartValue/60) minute\(timerStartValue/60 > 1 ? "s\(timerStartValue/60 == 5 ? " (RRS 26)" : "")": "")")
                    }
                }
                Section(header: Text("Timer Alerts")) {
                    Toggle("Speak Timer Alerts", isOn: $speakTimerAlerts)
                    Toggle("Audible Timer Alerts", isOn: $audibleTimerAlerts)
                }
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
                raceTimerValues: settings.raceTimerValues,
                speakTimerAlerts: settings.$speakTimerAlerts,
                audibleTimerAlerts: settings.$audibleTimerAlerts
            )
        }
    }
    return Preview()
    
}
