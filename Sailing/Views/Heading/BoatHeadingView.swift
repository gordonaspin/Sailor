//
//  HeadingView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct BoatHeadingView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = BoatHeadingSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let heading = BoatHeadingView.convertHeading(heading: settings.trueNorth ? locationManager.trueHeading : locationManager.magneticHeading)
        InstrumentView(
            instrumentName: "B.HDG",
            instrumentColor: settings.color,
            instrumentValue: heading,
            instrumentValueColor: settings.color,
            formatSpecifier: "%03d",
            showSign: false,
            instrumentTag: settings.trueNorth ? "TRUE" : "MAG",
            instrumentTagColor: settings.color,
            //fontSize: settings.fontSize,
            indicator: { ArrowIndicator(
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
            BoatHeadingSettingsView(
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
        @StateObject private var settings = BoatHeadingSettings.shared
        var body: some View {
            BoatHeadingView()
                .environment(LocationManager())
        }
    }
    return Preview()
}
