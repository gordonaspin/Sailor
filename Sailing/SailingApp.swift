//
//  SailingApp.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

@main
struct SailingApp: App {
    @Environment(\.scenePhase) private var phase
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
                SailingView()
                    .onAppear() {
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
                    .onDisappear() {
                        UIApplication.shared.isIdleTimerDisabled = false
                    }
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
        @State private var locationManager = LocationManager()
        var body: some View {
            if locationManager.isAuthorized {
                SailingView()
                    .environment(LocationManager())
                    .environment(MotionManager())
                    .environment(WeatherManager())
                    .environment(StopWatch(countDown: CountDown.shared))
                    .environment(CountDown.shared)
            }
            else {
                LocationDeniedView()
            }
        }
    }
    return Preview()
}

