//
//  SpeedView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct SpeedView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = SpeedSetttings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let speed = convertedSpeed
        InstrumentView(
            instrumentName: "SPD",
            instrumentColor: settings.color,
            instrumentValue: speed,
            instrumentValueColor: settings.color,
            formatSpecifier: "%.1f",
            showSign: false,
            instrumentTag: settings.speedUnits,
            fontSize: settings.fontSize,
            indicator: {EmptyView()}
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            SpeedSettingsView(
                speedUnits: settings.$speedUnits,
                shortUnits: settings.units,
                longUnits: settings.longUnits,
                colorIndex: settings.$colorIndex
            )
        }
    }
    
    private var convertedSpeed: Double {
        print("\(locationManager.speed)")
        return settings.convertSpeed(speed: locationManager.speed)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            SpeedView()
                .environment(LocationManager())
                .background(Color.black)
        }
    }
    return Preview()
}
