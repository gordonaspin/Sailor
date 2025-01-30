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
            InstrumentView(
                instrumentName: "W.DIR",
                instrumentColor: settings.color,
                instrumentValue: convertedWindDirection,
                instrumentValueColor: settings.color,
                formatSpecifier: "%03d",
                showSign: false,
                instrumentTag: "TRUE",
                fontSize: settings.fontSize,
                indicatorType: 1
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
