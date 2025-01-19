//
//  HeelAngleView.swift
//  Sailor
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
            widgetText: convertedPitch > 0 ? String(format: "\u{25BE}%02d", convertedPitch) : String(format: "\u{25B4}%02d", abs(convertedPitch)),
            color: settings.color,
            unitsText: "TRIM",
            unitsColor: settings.color,
            fontSize: settings.fontSize
        )
        .onTapGesture {
                isPickerPresented = true
        }
        .swipe(
            left: {
                settings.prevColor()
            },
            right: {
                settings.nextColor()
            })
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
