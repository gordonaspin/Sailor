//
//  SailorApp.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

@main
struct SailorApp: App {
    @State private var locationManager = LocationManager()
    @State private var motionManager = MotionManager()
    @State private var weatherManager = WeatherManager()
    @State private var stopWatch = StopWatch(countDown: CountDown.shared)
    @State private var countDown = CountDown.shared

    init() {
        print("SaliorApp init")
    }
    var body: some Scene {
        WindowGroup {
            if (locationManager.isAuthorized) {
                SailorView()
                    .onAppear() {
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
                    .onDisappear() {
                        UIApplication.shared.isIdleTimerDisabled = false
                        locationManager.stopTracking()
                    }
                    .background(Color.black)
            }
            else {
                LocationDeniedView()
            }
        }
        .environment(locationManager)
        .environment(motionManager)
        .environment(weatherManager)
        .environment(stopWatch)
        .environment(countDown)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            LocationDeniedView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
                .environment(StopWatch(countDown: CountDown.shared))
                .environment(CountDown())
        }
    }
    return Preview()
}

