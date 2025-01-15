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

    init() {
        print("SaliorApp init")
    }
    var body: some Scene {
        WindowGroup {
            SailorView()
                .onAppear() {
                    print("SaliorApp ContentView onAppear")
                    UIApplication.shared.isIdleTimerDisabled = true
                }
                .onDisappear() {
                    UIApplication.shared.isIdleTimerDisabled = false
                    locationManager.stopTracking()
                }
                .background(Color.black)
        }
        .environment(locationManager)
        .environment(motionManager)
    }
}
