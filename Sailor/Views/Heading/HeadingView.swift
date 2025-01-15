//
//  HeadingView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct HeadingView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = HeadingViewSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        VStack() {
            Text("\(settings.trueNorth ? "true" : "magnetic") heading")
                .font(.title)
                .foregroundColor(settings.color)
            
            Text("\(convertedHeading, specifier: "%03d")º")
                .font(.system(size: settings.fontSize).monospacedDigit())
                .bold()
                .foregroundColor(settings.color)
                .onTapGesture {
                    isPickerPresented = true
                }
                .swipe( left: {
                            settings.prevColor()
                        },
                        right: {
                            settings.nextColor()
                        })
        }
        .sheet(isPresented: $isPickerPresented) {
            TrueOrMagneticHeadingPickerView(trueNorth: $settings.trueNorth, colorIndex: $settings.colorIndex)
        }
    }
    
    private var convertedHeading: Int {
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
        @StateObject private var settings = HeadingViewSettings.shared
        var body: some View {
            HeadingView()
                .environment(LocationManager())
        }
    }
    return Preview()
}
