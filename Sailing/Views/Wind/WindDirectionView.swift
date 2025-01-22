//
//  WindDirectionView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/19/25.
//

import SwiftUI

struct WindDirectionView: View {
    @Environment(WeatherManager.self) var weatherManager
    @StateObject private var settings = WindDirectionSettings.shared
    @State private var isPickerPresented: Bool = false
    
    var body: some View {
        ZStack {
            InstrumentView(
                instrumentName: "W.DIR",
                instrumentValue: String(format: "%03d", convertedWindDirection),
                color: settings.color,
                instrumentUnits: "DEG",
                unitsColor: settings.color,
                fontSize: settings.fontSize,
                withIndicator: true,
                indicatorAdjustment: 0
            )
            .onTapGesture(count: 2) {
                isPickerPresented = true
            }
            .sheet(isPresented: $isPickerPresented) {
                WindDirectionSettingsView(colorIndex: settings.$colorIndex)
            }
        }
    }
    
    private var convertedWindDirection: Int {
        print("\(Date().toTimestamp) - \(#function) \(weatherManager.windDirection)")
        return Int(weatherManager.windDirection)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            WindDirectionView()
                .environment(WeatherManager())
        }
    }
    return Preview()
}
