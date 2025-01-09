//
//  HeelAngleView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct HeelAngleView: View {
    @StateObject private var manager = MotionManager.shared
    var settings = HeelAngleViewSettings.shared

    var body: some View {
        VStack() {
            Text("heel")
                .font(.title)
                .foregroundColor(settings.color)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    let orientation = UIDevice.current.orientation.rawValue
                    let orientationName = getOrientation(orientation: orientation)
                    if UIDevice.current.orientation.isValidInterfaceOrientation
                    {
                        print("HeelAngleView: \(orientation) \(orientationName)")
                    }
                    else {
                        print("HeelAngleView: invalid orientation \(orientation) \(orientationName)")
                    }
                }
            
            Text("\(convertedHeel, specifier: "%02d")º")
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
    
    private var convertedHeel: Int {
        print("updating heel angle")
        var tilt: Int = 0
        switch UIDevice.current.orientation.rawValue {
            case 1: tilt = manager.rollAngle        // portrait
            case 2: tilt = manager.rollAngle        // upside down
            case 3: tilt = manager.yawAngle - 90   // landscape right
            case 4: tilt = 90 - manager.yawAngle   // landscape left
            default: tilt = manager.rollAngle
        }
        if (abs(tilt) >= settings.minimumHeelAngle && abs(tilt) <= settings.maximumHeelAngle) {
            settings.setOptimumTiltColor()
        }
        else {
            settings.setChosenColor()
        }
        return tilt
    }
}

#Preview {
    struct Preview: View {
        private var settings = HeelAngleViewSettings.shared
        var body: some View {
            HeelAngleView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
