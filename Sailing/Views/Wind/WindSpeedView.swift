//
//  WindSpeedView.swift
//  Sailor
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
            widgetText: String(format: "%.1f", weatherManager.windSpeed), color: settings.color,
            unitsText: settings.speedUnits,
            unitsColor: settings.color,
            fontSize: settings.fontSize
        )
        .onTapGesture {
            isPickerPresented = true
        }
        .swipe(
            left: {
                settings.prevColor()
            },
            right: {
                settings.nextColor()
            }
        )
        .sheet(isPresented: $isPickerPresented) {
            WindSpeedSettingsView(
                speedUnits: settings.$speedUnits,
                items: settings.units,
                colorIndex: settings.$colorIndex
            )
        }
    }
    
    private var convertedSpeed: Double {
        print("\(Date().toTimestamp) - \(#function) - \(weatherManager.windSpeed)")
        return settings.convertSpeed(speed: weatherManager.windSpeed)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            WindSpeedView()
                .environment(WeatherManager())
        }
    }
    return Preview()
}
