//
//  PitchAngleView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct PitchAngleView: View {
    @Environment(MotionManager.self) private var motionManager
    @StateObject private var settings = PitchAngleSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let pitch = convertedPitch
        InstrumentView(
            instrumentName: "TRIM",
            instrumentColor: settings.color,
            instrumentValue: pitch,
            instrumentValueColor: settings.color,
            formatSpecifier: "%d",
            showSign: false,
            instrumentTag: pitch < 0 ? "AFT" : "FWD",
            instrumentTagColor: settings.color,
            indicator: { PitchIndicator(
                color: settings.color,
                angle: pitch)
            }
        )
        .onTapGesture(count: 2) {
                isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            PitchAngleSettingsView(colorIndex: settings.$colorIndex)
        }
    }

    private var convertedPitch: Int {
        print("motionManager.pitchAngle:", "\(motionManager.pitchAngle)")
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
