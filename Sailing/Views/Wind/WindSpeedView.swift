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
            instrumentName: "W.SPD",
            instrumentValue: String(format: "%.1f", convertedSpeed),
            color: settings.color,
            instrumentUnits: settings.speedUnits,
            unitsColor: settings.color,
            fontSize: settings.fontSize
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        /*.swipe(
            left: {
                settings.prevColor()
            },
            right: {
                settings.nextColor()
            }
        )*/
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
                .background(Color.black)

        }
    }
    return Preview()
}
