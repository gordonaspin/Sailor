//
//  HeadingView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct HeadingView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = HeadingSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let heading = convertedHeading
        InstrumentView(
            instrumentName: "HDG",
            instrumentColor: settings.color,
            instrumentValue: heading,
            instrumentValueColor: settings.color,
            formatSpecifier: "%03d",
            showSign: false,
            instrumentTag: settings.trueNorth ? "TRUE" : "MAG",
            instrumentTagColor: settings.color,
            fontSize: settings.fontSize,
            indicator: { ArrowView(
                color: settings.color,
                angle: heading,
                width: 10,
                height: 25)
            }
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            HeadingSettingsView(
                trueNorth: $settings.trueNorth,
                colorIndex: $settings.colorIndex
            )
        }
    }
    
    private var convertedHeading: Int {
        print("settings.trueNorth", "\(settings.trueNorth)", "true:", "\(locationManager.trueHeading)", "magnetic:", "\(locationManager.magneticHeading)")
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
