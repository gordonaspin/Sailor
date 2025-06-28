//
//  BoatSpeedView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct BoatSpeedView: View {
    @Environment(LocationManager.self) private var locationManager
    @StateObject private var settings = BoatSpeedSetttings.shared
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
            instrumentTagColor: settings.color,
            indicator: {
                VStack {
                    Image(systemName: "target").foregroundColor(accuracyColor)
                    Text(convertedAccuracy)
                        .font(.footnote)
                        .frame(width: 50)
                        .foregroundColor(accuracyColor)
                }
            }
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
    private var accuracyColor: Color {
        if locationManager.horizontalAccuracy < 0 {
            return .gray
        }
        if locationManager.horizontalAccuracy < 10 {
            return .green
        }
        if locationManager.horizontalAccuracy < 100 {
            return .yellow
        }
        if locationManager.horizontalAccuracy < 1000 {
            return .orange
        }
        return .red
    }
    private var convertedAccuracy: String {
        var str = ""
        if locationManager.horizontalAccuracy < 0 {
            str = "---"
        }
        else {
            if settings.speedUnits == "KTS" {
                if locationManager.horizontalAccuracy < 1852 / 4 { // < 0.25nm, convert meters to feet
                    str = String(format: "%d'", Int(locationManager.horizontalAccuracy * 3.28084))
                }
                else {
                    str = String(format: "%.1fnm", locationManager.horizontalAccuracy * 0.000539957)
                }
            }
            else if settings.speedUnits == "MPH" {
                if locationManager.horizontalAccuracy < 1609 / 4 { // < 0.24mi, convert meters to feet
                    str = String(format: "%d'", Int(locationManager.horizontalAccuracy * 3.28084))
                }
                else {
                    str = String(format: "%.1fmi", locationManager.horizontalAccuracy * 0.000621371)
                }
            }
            else {  // kmh
                if locationManager.horizontalAccuracy < 250 { // < 0.25km
                    str = String(format: "%dm", Int(locationManager.horizontalAccuracy))
                }
                else {
                    str = String(format: "%.1fkm", locationManager.horizontalAccuracy / 1000)
                }
            }
        }
        print(str)
        return str
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
