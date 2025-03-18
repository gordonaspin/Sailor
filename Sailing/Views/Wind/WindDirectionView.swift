//
//  WindDirectionView.swift
//  Sailing
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
            let windDirection = convertedWindDirection
            InstrumentView(
                instrumentName: "WDIR",
                instrumentColor: settings.color,
                instrumentValue: windDirection,
                instrumentValueColor: settings.color,
                formatSpecifier: "%03d",
                showSign: false,
                instrumentTag: "TRUE",
                instrumentTagColor: settings.color,
                indicator: { BeaufortWindIndicator(
                    color: settings.color,
                    direction: windDirection,
                    speed: weatherManager.windSpeed * 0.539957, // knots
                    cloudCover: weatherManager.cloudCover)//,
                    //width: 10,
                    //height: 25)
                }
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
        print("\(weatherManager.windDirection)")
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
