//
//  HeelAngleView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI
import AVFoundation

struct HeelAngleView: View {
    @StateObject private var manager = MotionManager.shared
    @StateObject private var settings = HeelAngleViewSettings.shared
    @State private var isPickerPresented: Bool = false
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack() {
            Text("heel")
                .font(.title)
                .foregroundColor(settings.titleColor)
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
        //.onChange(of: optimumHeelValue) {
        //    settings.optimumHeelAngle = optimumHeelValue
        //}
        //.onChange(of: underHeelAlarm) {
        //    settings.underHeelAlarm = underHeelAlarm
        //}
        //.onChange(of: overHeelAlarm) {
        //    settings.overHeelAlarm = overHeelAlarm
        //}
        .sheet(isPresented: $isPickerPresented) {
            HeelAngleLimitsPickerView(  optimumHeelAngle: $settings.optimumHeelAngle,
                                        underHeelAlarm: $settings.underHeelAlarm,
                                        overHeelAlarm: $settings.overHeelAlarm)
        }
        //.onAppear() {
            //optimumHeelValue = settings.optimumHeelAngle
            //overHeelValue = settings.maximumHeelAngle
            //underHeelAlarm = settings.underHeelAlarm
            //overHeelAlarm = settings.overHeelAlarm
        //}
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
        print("updating heel angle")
        var tilt: Int = 0
        switch UIDevice.current.orientation.rawValue {
            case 1: tilt = manager.rollAngle        // portrait
            case 2: tilt = manager.rollAngle        // upside down
            case 3: tilt = manager.yawAngle - 90   // landscape right
            case 4: tilt = 90 - manager.yawAngle   // landscape left
            default: tilt = manager.rollAngle
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
        @StateObject private var settings = HeelAngleViewSettings.shared
        var body: some View {
            HeelAngleView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
