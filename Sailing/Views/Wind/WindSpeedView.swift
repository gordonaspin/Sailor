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
        let windSpeed = convertedWindSpeed
        InstrumentView(
            instrumentName: "W.SPD",
            instrumentColor: settings.color,
            instrumentValue: windSpeed,
            instrumentValueColor: settings.color,
            formatSpecifier: "%.1f",
            showSign: false,
            instrumentTag: settings.speedUnits,
            instrumentTagColor: settings.color,
            fontSize: settings.fontSize,
            indicator: {EmptyView()}
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
        print("\(weatherManager.windSpeed)")
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
