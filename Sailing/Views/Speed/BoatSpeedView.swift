//
//  SpeedView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct BoatSpeedView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = BoatSpeedSetttings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let speed = convertedSpeed
        InstrumentView(
            instrumentName: "B.SPD",
            instrumentColor: settings.color,
            instrumentValue: speed,
            instrumentValueColor: settings.color,
            formatSpecifier: "%.1f",
            showSign: false,
            instrumentTag: settings.speedUnits,
            instrumentTagColor: settings.color,
            //fontSize: settings.fontSize,
            indicator: {EmptyView()}
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            BoatSpeedSettingsView(
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
            BoatSpeedView()
                .environment(LocationManager())
                .background(Color.black)
        }
    }
    return Preview()
}
