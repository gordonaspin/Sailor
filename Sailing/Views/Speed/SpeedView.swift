//
//  SpeedView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct SpeedView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = SpeedSetttings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        InstrumentView(
            instrumentName: "SPD",
            instrumentValue: convertedSpeed,
            formatSpecifier: "%.1f",
            showSign: false,
            color: settings.color,
            instrumentUnits: settings.speedUnits,
            unitsColor: settings.color,
            fontSize: settings.fontSize,
            withIndicator: false,
            indicatorAdjustment: 0
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            SpeedSettingsView(
                speedUnits: settings.$speedUnits,
                items: settings.units,
                colorIndex: settings.$colorIndex
            )
        }
    }
    
    private var convertedSpeed: Double {
        print("\(Date().toTimestamp) - \(#function) \(locationManager.speed)")
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
