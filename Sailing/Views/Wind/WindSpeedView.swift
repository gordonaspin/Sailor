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
        let windSpeed = convertWindSpeed(speed: weatherManager.windSpeed)
        InstrumentView(
            instrumentName: "W.SPD",
            instrumentColor: settings.color,
            instrumentValue: windSpeed,
            instrumentValueColor: settings.color,
            formatSpecifier: "%.1f",
            showSign: false,
            instrumentTag: settings.speedUnits,
            instrumentTagColor: settings.color,
            indicator: {
                VStack {
                    Image(systemName: weatherManager.weatherSymbolName).foregroundColor(settings.color)
                    Text(String(format: "%d", Int(convertWindSpeed(speed: weatherManager.windGustSpeed))))
                        .font(.footnote)
                        .frame(width: 50)
                        .foregroundColor(settings.color)
                }
            }
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
    
    private func convertWindSpeed(speed: Double) ->Double {
        print("\(weatherManager.windSpeed)")
        return settings.convertSpeed(speed: speed)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            WindSpeedView()
                .environment(WeatherManager())
                //.background(Color.black)
        }
    }
    return Preview()
}
