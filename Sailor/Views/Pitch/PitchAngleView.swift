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
        VStack() {
            Text("pitch")
                .font(.title)
                .foregroundColor(settings.color)
            
            Text("\(convertedPitch, specifier: "%02d")º")  //°
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
            PitchAngleSettingsView(colorIndex: settings.$colorIndex)
        }
    }

    private var convertedPitch: Int {
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
