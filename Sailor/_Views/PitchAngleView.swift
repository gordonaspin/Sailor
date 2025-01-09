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
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    let orientation = UIDevice.current.orientation.rawValue
                    let orientationName = getOrientation(orientation: orientation)
                    if UIDevice.current.orientation.isValidInterfaceOrientation
                    {
                        print("PitchAngleView: \(orientation) \(orientationName)")
                    }
                    else {
                        print("PitchAngleView: invalid orientation \(orientation) \(orientationName)")
                    }
                }
            
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
        print("updating pitch angle")
        switch UIDevice.current.orientation.rawValue {
        case 1: return manager.pitchAngle        // portrait
        case 2: return manager.pitchAngle        // upside down
        case 3: return manager.pitchAngle        // landscape right
        case 4: return manager.pitchAngle        // landscape left
        default: return manager.pitchAngle
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
