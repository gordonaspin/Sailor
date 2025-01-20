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
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            LocationDeniedView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}

