//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

struct SailorView: View {
    @Environment(LocationManager.self) var locationManager
    @Environment(MotionManager.self) var motionManager
    @Environment(WeatherManager.self) var weatherManager
    @State var isRaceTimerPresented: Bool = false
    var body: some View {
        VStack {
            if !isRaceTimerPresented {
                ZStack {
                    MapView()
                    DefaultLayoutView()
                }
                .onAppear() {
                    print("\(Date().toTimestamp) -  \(#file) \(#function) Map & DefaultLayoutView onAppear, start tracking")
                    locationManager.startTracking()
                    motionManager.startTracking()
                }
                
            }
            else {
                RaceTimerView(isPresented: $isRaceTimerPresented)
                    .onAppear {
                        print("\(Date().toTimestamp) -  \(#file) \(#function) RaceTimerView onAppear, stop tracking")
                        locationManager.stopTracking()
                        motionManager.stopTracking()
                    }
            }
        }
        .swipe(
            left: {
                isRaceTimerPresented.toggle()
            },
            right: {
                isRaceTimerPresented.toggle()
            }
        )
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            SailorView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
                .environment(StopWatch(countDown: CountDown.shared))
                .environment(CountDown())
        }
    }
    return Preview()
}
