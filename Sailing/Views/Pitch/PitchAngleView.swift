//
//  PitchAngleView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct PitchAngleView: View {
    @Environment(MotionManager.self) var motionManager
    @StateObject private var settings = PitchAngleSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        InstrumentView(
            instrumentName: "TRIM",
            instrumentValue: convertedPitch,
            formatSpecifier: "%d",
            showSign: false,
            color: settings.color,
            instrumentUnits: "DEG",
            unitsColor: settings.color,
            fontSize: settings.fontSize,
            withIndicator: true,
            indicatorAdjustment: +90
        )
        .onTapGesture(count: 2) {
                isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            PitchAngleSettingsView(colorIndex: settings.$colorIndex)
        }
    }

    private var convertedPitch: Int {
        print("\(Date().toTimestamp) - \(#function) motionManager.pitchAngle: \(motionManager.pitchAngle)")
        switch UIDevice.current.orientation {
            case .portrait:              return Int(motionManager.pitchAngle)
            case .portraitUpsideDown:    return Int(motionManager.pitchAngle)
            case .landscapeRight:        return Int(motionManager.pitchAngle)
            case .landscapeLeft:         return Int(motionManager.pitchAngle)
            default:                     return Int(motionManager.pitchAngle)
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            PitchAngleView()
                .environment(MotionManager())
        }
    }
    return Preview()
}
