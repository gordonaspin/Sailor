//
//  HeelAngleView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI
import AVFoundation

struct HeelAngleView: View {
    @Environment(MotionManager.self) var motionManager
    @Environment(LocationManager.self) var locationManager
    @Environment(WeatherManager.self) var weatherManager
    @StateObject private var settings = HeelAngleSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        let heel = HeelAngleView.convertHeel(
            rollAngle: motionManager.rollAngle,
            yawAngle: motionManager.yawAngle
        )
        InstrumentView(
            instrumentName: "HEEL",
            instrumentColor: settings.titleColor,
            instrumentValue: heel,
            instrumentValueColor: settings.color,
            formatSpecifier: "%d",
            showSign: false,
            instrumentTag: settings.heelAngleWindwardLeeward ?
                determineHeelDirection(
                    windDirection: weatherManager.windDirection,
                    vesselHeading: locationManager.trueHeading,
                    heelAngle: heel) :
                heel < 0 ? "PORT" : "STBD",
            instrumentTagColor: settings.heelAngleWindwardLeeward ? settings.color :  heel < 0 ? Color.red : Color.green,
            //fontSize: settings.fontSize,
            indicator: { HeelIndicator(
                color: settings.color,
                angle: heel,
                width: 10,
                height: 25
            )}
        )
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .sheet(isPresented: $isPickerPresented) {
            HeelAngleSettingsView(
                colorIndex: $settings.colorIndex,
                optimumHeelColorIndex: $settings.optimumHeelColorIndex,
                optimumHeelAngle: $settings.optimumHeelAngle,
                speakHeelAlarms: $settings.speakHeelAlarms,
                underHeelAlarm: $settings.underHeelAlarm,
                overHeelAlarm: $settings.overHeelAlarm,
                heelAngleWindwardLeeward: $settings.heelAngleWindwardLeeward,
                optimumHeelAngles: settings.optimumHeelAngles
            )
        }
    }
    
    public static func convertHeel(rollAngle: Double, yawAngle: Double) -> Int {
        print("motionManager.rollAngle:", "\(rollAngle)", "motionManager.yawAngle:", "\(yawAngle)")
        let settings = HeelAngleSettings.shared
        var tilt: Int = 0
        switch UIDevice.current.orientation {
            case .portrait:              tilt = Int(rollAngle)
            case .portraitUpsideDown:    tilt = Int(rollAngle)
            case .landscapeLeft:         tilt = Int(yawAngle - 90)
            case .landscapeRight:        tilt = Int(90 - yawAngle)
            default: tilt = Int(rollAngle)
        }
        if (abs(tilt) >= (settings.optimumHeelAngle - 5) && abs(tilt) <= (settings.optimumHeelAngle + 5)) {
            settings.setOptimumHeelColor()
        }
        else {
            settings.resetColor()
        }
        return tilt
    }
    

    private func determineHeelDirection(windDirection: Double, vesselHeading: Double, heelAngle: Int) -> String {
        // Compute True Wind Angle (TWA)
        let TWA = (windDirection - vesselHeading + 360).truncatingRemainder(dividingBy: 360)

        // Determine windward side
        let windFromStarboard = (TWA < 180)  // Wind coming from starboard
        let windFromPort = (TWA >= 180)      // Wind coming from port

        // Determine heel direction
        let heelingToStarboard = (heelAngle > 0) // Positive heel means starboard heel
        let heelingToPort = (heelAngle < 0)      // Negative heel means port heel

        print("Wind Dir:", "\(windDirection)", "Heading:", "\(vesselHeading)", "heel:", "\(heelAngle)", "TWA:", "\(TWA)", "windFromStarboard:", "\(windFromStarboard)", "windFromPort:", "\(windFromPort)", "heelingToStarboard:", "\(heelingToStarboard)", "heelingToPort:", "\(heelingToPort)")
        // Compare heel direction with windward side
        if (windFromStarboard && heelingToStarboard) || (windFromPort && heelingToPort) {
            return "WD"
        } else {
            return "LEE"
        }
    }}

#Preview {
    struct Preview: View {
        var body: some View {
            HeelAngleView()
                .environment(MotionManager())
                .environment(LocationManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
