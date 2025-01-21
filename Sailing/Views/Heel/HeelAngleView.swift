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
    @StateObject private var settings = HeelAngleSettings.shared
    @State private var isPickerPresented: Bool = false
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        InstrumentView(
            instrumentName: "HEEL",
            instrumentValue: convertedHeel > 0 ? String(format: "\u{25B8}%02d", convertedHeel) : String(format: "\u{25C2}%02d", abs(convertedHeel)),
            color: settings.color,
            instrumentUnits: "DEG",
            unitsColor: settings.titleColor,
            fontSize: settings.fontSize
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        /*.swipe(
            left: {
                settings.prevColor()
            },
            right: {
                settings.nextColor()
            }
         )*/
        .sheet(isPresented: $isPickerPresented) {
            HeelAngleSettingsView(
                colorIndex: $settings.colorIndex,
                optimumHeelColorIndex: $settings.optimumHeelColorIndex,
                optimumHeelAngle: $settings.optimumHeelAngle,
                speakHeelAlarms: $settings.speakHeelAlarms,
                underHeelAlarm: $settings.underHeelAlarm,
                overHeelAlarm: $settings.overHeelAlarm,
                optimumHeelAngles: settings.optimumHeelAngles
            )
        }
        .onReceive(timer) { _ in
            if (settings.speakHeelAlarms) {
                if (abs(convertedHeel) < settings.optimumHeelAngle - 5) {
                    synthesizer.speak(AVSpeechUtterance(string: settings.underHeelAlarm))
                }
                else if (abs(convertedHeel) > settings.optimumHeelAngle + 5) {
                    synthesizer.speak(AVSpeechUtterance(string: settings.overHeelAlarm))
                }
            }
        }
        .onAppear {
            motionManager.startTracking()
        }
        .onDisappear() {
            motionManager.stopTracking()
        }
    }
    
    private var convertedHeel: Int {
        print("\(Date().toTimestamp) - \(#function) motionManager.rollAngle: \(motionManager.rollAngle) motionManager.yawAngle: \(motionManager.yawAngle)")
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
