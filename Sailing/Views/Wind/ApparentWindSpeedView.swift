//
//  ApparentWindSpeedView.swift
//  Sailing
//
//  Created by Gordon Aspin on 2/11/25.
//

import SwiftUI

struct ApparentWindSpeedView: View {
    @Environment(WeatherManager.self) var weatherManager
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = ApparentWindSpeedSetttings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let windSpeed = apparentWindSpeed
        InstrumentView(
            instrumentName: "AWS",
            instrumentColor: settings.color,
            instrumentValue: windSpeed,
            instrumentValueColor: settings.color,
            formatSpecifier: "%.1f",
            showSign: false,
            instrumentTag: settings.speedUnits,
            instrumentTagColor: settings.color,
            indicator: {EmptyView()}
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            ApparentWindSpeedSettingsView(
                speedUnits: settings.$speedUnits,
                shortUnits: settings.units,
                longUnits:  settings.longUnits,
                colorIndex: settings.$colorIndex
            )
        }
    }
    
    private var apparentWindSpeed: Double {
        let BS: Double = locationManager.speed * 3.6 // m/s to km/h
        let BH: Double = locationManager.trueHeading
        let TWS: Double = weatherManager.windSpeed // km/h
        let TWD: Double = weatherManager.windDirection
        let thetaDegrees: Double = (TWD - BH)
        let thetaRads: Double = thetaDegrees * .pi / 180
        
        print("bs:", "\(BS)", "bh:", "\(BH)", "tws:", "\(TWS)", "twd:", "\(TWD)", "theta:", "\(thetaDegrees)")
        let AWS = sqrt((TWS * TWS) + (BS * BS) + (2 * TWS * BS * cos(thetaRads)))
        print("aws:", "\(AWS)", "theta:", "\(thetaDegrees)", "cos(theta):", "\(cos(thetaRads))")
        return settings.convertSpeed(speed: AWS)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            ApparentWindSpeedView()
                .environment(WeatherManager())
                .environment(LocationManager())
                .background(Color.black)
        }
    }
    return Preview()
}
