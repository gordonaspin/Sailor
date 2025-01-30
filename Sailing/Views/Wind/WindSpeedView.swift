//
//  WindSpeedView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/19/25.
//

import SwiftUI

struct WindSpeedView: View {
    @Environment(WeatherManager.self) var weatherManager
    @StateObject private var settings = WindSpeedSetttings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        InstrumentView(
            instrumentName: "W.SPD",
            instrumentColor: settings.color,
            instrumentValue: convertedWindSpeed,
            instrumentValueColor: settings.color,
            formatSpecifier: "%.1f",
            showSign: false,
            instrumentTag: settings.speedUnits,
            fontSize: settings.fontSize,
            indicatorType: 0
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            WindSpeedSettingsView(
                speedUnits: settings.$speedUnits,
                shortUnits: settings.units,
                longUnits:  settings.longUnits,
                colorIndex: settings.$colorIndex
            )
        }
    }
    
    private var convertedWindSpeed: Double {
        print("\(Date().toTimestamp) - \(#function) \(weatherManager.windSpeed)")
        return settings.convertSpeed(speed: weatherManager.windSpeed)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            WindSpeedView()
                .environment(WeatherManager())
                .background(Color.black)
        }
    }
    return Preview()
}
