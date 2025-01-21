//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

struct SailorView: View {
    @State var isRaceTimerPresented: Bool = false
    var body: some View {
        VStack {
            if !isRaceTimerPresented {
                ZStack {
                    MapView()
                    DefaultLayoutView()
                }
            }
            else {
                RaceTimerView(isPresented: $isRaceTimerPresented)
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
