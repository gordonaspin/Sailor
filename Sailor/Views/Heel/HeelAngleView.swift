//
//  HeelAngleView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI
import AVFoundation

struct HeelAngleView: View {
    @Environment(MotionManager.self) var motionManager
    @StateObject private var settings = HeelAngleViewSettings.shared
    @State private var isPickerPresented: Bool = false
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack() {
            Text("heel")
                .font(.title)
                .foregroundColor(settings.titleColor)
            
            Text("\(convertedHeel, specifier: "%02d")º")
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
            HeelAngleLimitsPickerView(  optimumHeelAngle: $settings.optimumHeelAngle,
                                        underHeelAlarm: $settings.underHeelAlarm,
                                        overHeelAlarm: $settings.overHeelAlarm,
                                        colorIndex: $settings.colorIndex,
                                        optimumHeelColorIndex: $settings.optimumHeelColorIndex,
                                        optimumHeelAngles: settings.optimumHeelAngles
                                    )
        }
        .onReceive(timer) {
            _ in
            if (abs(convertedHeel) < settings.optimumHeelAngle - 5) {
                synthesizer.speak(AVSpeechUtterance(string: settings.underHeelAlarm))
            }
            else if (abs(convertedHeel) > settings.optimumHeelAngle + 5) {
                synthesizer.speak(AVSpeechUtterance(string: settings.overHeelAlarm))
            }
        }
    }
    
    private var convertedHeel: Int {
        var tilt: Int = 0
        switch UIDevice.current.orientation {
            case .portrait:              tilt = Int(motionManager.rollAngle)
            case .portraitUpsideDown:    tilt = Int(motionManager.rollAngle)
            case .landscapeRight:        tilt = Int(motionManager.yawAngle - 90)
            case .landscapeLeft:         tilt = Int(90 - motionManager.yawAngle)
            default: tilt = Int(motionManager.rollAngle)
        }
        if (abs(tilt) >= (settings.optimumHeelAngle - 5) && abs(tilt) <= (settings.optimumHeelAngle + 5)) {
            settings.setOptimumHeelColor()
        }
        else {
            settings.resetColor()
        }
        return tilt
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            HeelAngleView()
                .environment(MotionManager())

        }
    }
    return Preview()
}
