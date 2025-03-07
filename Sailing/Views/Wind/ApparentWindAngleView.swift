//
//  ApparentWindAngleView.swift
//  Sailing
//
//  Created by Gordon Aspin on 2/11/25.
//

import SwiftUI

struct ApparentWindAngleView: View {
    @Environment(WeatherManager.self) var weatherManager
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = ApparentWindAngleSettings.shared
    @State private var isPickerPresented: Bool = false
    
    var body: some View {
        ZStack {
            let apparentWindAngle = calculateApparentWindAngle
            let portOrStarboard = apparentWindAngle < 0 ? "PORT" : "STBD"
            InstrumentView(
                instrumentName: "AWA",
                instrumentColor: settings.color,
                instrumentValue: apparentWindAngle,
                instrumentValueColor: settings.color,
                formatSpecifier: "%03d",
                showSign: false,
                instrumentTag: portOrStarboard,
                instrumentTagColor: apparentWindAngle < 0 ? Color.red : Color.green,
                indicator: { ApparentWindAngleIndicator(
                    color: apparentWindAngle < 0 ? Color.red : Color.green,
                    angle: apparentWindAngle)
                }
            )
            .onTapGesture(count: 2) {
                isPickerPresented = true
            }
            .sheet(isPresented: $isPickerPresented) {
                ApparentWindAngleSettingsView(colorIndex: settings.$colorIndex)
            }
        }
    }
    
    private var calculateApparentWindAngle: Int {
        let BS: Double = locationManager.speed * 3.6 // m/s to km/h
        let BH: Double = Double(BoatHeadingView.convertHeading(heading: locationManager.trueHeading)) 
        let TWS: Double = weatherManager.windSpeed // km/h
        let TWD: Double = weatherManager.windDirection
        let thetaDegrees: Int = Int(TWD - BH)
        let thetaRads: Double = Double(thetaDegrees) * .pi / 180
        var difference: Int = thetaDegrees
        
        print("bs:", "\(BS)", "bh:", "\(BH)", "tws:", "\(TWS)", "twd:", "\(TWD)", "theta:", "\(thetaDegrees)")
        
        let AWA = acos((TWS * cos(thetaRads) + BS)/(sqrt(TWS*TWS + BS * BS + 2 * TWS * BS * cos(thetaRads)))) * 180 / .pi

        print("awa:", "\(AWA)", "theta:", "\(thetaDegrees)", "cos(theta):", "\(cos(thetaRads))")
        if AWA.isNaN {
            return 0
        }
        
        // determine if port or starboard
        if difference > 180 {
            difference -= 360
        } else if difference < -180 {
            difference += 360
        }
        
        // If the difference is positive, it's starboard (right), if negative it's port (left)
        if difference > 0 {
            return Int(AWA)
        } else {
            return Int(-AWA)
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            ApparentWindAngleView()
                .environment(WeatherManager())
                .environment(LocationManager())
        }
    }
    return Preview()
}
