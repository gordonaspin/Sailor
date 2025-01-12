//
//  HeelAngleView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct PitchAngleView: View {
    @StateObject private var manager = MotionManager.shared
    private var settings = PitchAngleViewSettings.shared

    var body: some View {
        VStack() {
            Text("pitch")
                .font(.title)
                .foregroundColor(settings.color)
            
            Text("\(convertedPitch, specifier: "%02d")º")  //°
                .font(.system(size: settings.fontSize).monospacedDigit())
                .bold()
                .foregroundColor(settings.color)
                .swipe( left: {
                            settings.prevColor()
                        },
                        right: {
                            settings.nextColor()
                        })
        }
    }

    private var convertedPitch: Int {
        switch UIDevice.current.orientation {
            case .portrait:              return manager.pitchAngle
            case .portraitUpsideDown:    return manager.pitchAngle
            case .landscapeRight:        return manager.pitchAngle
            case .landscapeLeft:         return manager.pitchAngle
            default:                     return manager.pitchAngle
        }
    }
}

#Preview {
    struct Preview: View {
        private var settings = PitchAngleViewSettings.shared
        var body: some View {
            PitchAngleView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
