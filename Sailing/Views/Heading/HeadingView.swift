//
//  HeadingView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct HeadingView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = HeadingSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        InstrumentView(
            instrumentName: "HDG",
            instrumentValue: String(format: "%03d", convertedHeading),
            color: settings.color,
            instrumentUnits: settings.trueNorth ? "TRUE" : "MAG",
            unitsColor: settings.color,
            fontSize: settings.fontSize,
            withIndicator: true,
            indicatorAdjustment: 0
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            HeadingSettingsView(
                trueNorth: $settings.trueNorth,
                colorIndex: $settings.colorIndex,
                mapFollowsHeading: $settings.mapFollowsHeading
            )
        }
    }
    
    private var convertedHeading: Int {
        print("\(Date().toTimestamp) - \(#function) \(settings.trueNorth ? "trueHeading  \(locationManager.trueHeading)" : "magneticHeading \(locationManager.magneticHeading)")")
        let heading: Int = Int(settings.trueNorth ? locationManager.trueHeading : locationManager.magneticHeading)
        switch UIDevice.current.orientation {
            case .portrait:
                return heading
            case .portraitUpsideDown:
                return abs(heading + 180) % 360
            case .landscapeRight:
                return (heading + 270) % 360
            case .landscapeLeft:
                return (heading + 90) % 360
            default: return heading
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            HeadingView()
                .environment(LocationManager())
        }
    }
    return Preview()
}
