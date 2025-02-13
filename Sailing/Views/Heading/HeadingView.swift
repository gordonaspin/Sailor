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
        let heading = HeadingView.convertHeading(heading: settings.trueNorth ? locationManager.trueHeading : locationManager.magneticHeading)
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
    
    public static func convertHeading(heading: Double) -> Int {
        
        var newHeading: Int = 0
        switch UIDevice.current.orientation {
            case .portrait:
                newHeading = Int(heading)
            case .portraitUpsideDown:
                newHeading = abs(Int(heading) + 180) % 360
            case .landscapeRight:
                newHeading = (Int(heading) + 270) % 360
            case .landscapeLeft:
                newHeading = (Int(heading) + 90) % 360
            default: newHeading = Int(heading)
        }
        print("heading:", "\(Int(heading))", "newHeading:", "\(newHeading)")
        return newHeading
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
