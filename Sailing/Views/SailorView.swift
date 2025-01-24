//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

struct SailorView: View {
    @State private var views: [AnyView] = [
        AnyView(AllInstrumentsLayoutView()),
        AnyView(SpeedHeadingHeelPitchInstrumentsLayoutView()),
        AnyView(SpeedHeadingInstrumentsLayoutView())
    ]
    
    @Environment(LocationManager.self) var locationManager
    @Environment(MotionManager.self) var motionManager
    @Environment(WeatherManager.self) var weatherManager
    @Environment(\.colorScheme) var colorScheme
    @State var isRaceTimerPresented: Bool = false
    @State var viewIndex: Int = 0
    @State private var offset: CGFloat = 0
    @State private var backgroundColor: Color = .clear
    @State private var scaleFactor: CGFloat = 1
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                ZStack {
                    MapView()
                    if !isRaceTimerPresented {
                        views[viewIndex]
                            .offset(x: offset)
                            .scaleEffect(scaleFactor)
                            .background(backgroundColor)
                            .onAppear() {
                                print("\(Date().toTimestamp) -  \(#file) \(#function) Map & DefaultLayoutView onAppear, start tracking")
                                locationManager.startTracking()
                                motionManager.startTracking()
                            }
                    }
                    else {
                        RaceTimerView(isPresented: $isRaceTimerPresented, viewIndex: $viewIndex)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .offset(x: offset)
                            .scaleEffect(scaleFactor)
                            .onAppear {
                                print("\(Date().toTimestamp) -  \(#file) \(#function) RaceTimerView onAppear, stop tracking")
                                locationManager.stopTracking()
                                motionManager.stopTracking()
                            }
                    }
                }
            }
            .animation(.spring(), value: offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation.width
                        if abs(gesture.translation.width) > geometry.size.width / 8 {
                            backgroundColor = Color.gray.opacity(0.9)
                            scaleFactor = 0.9
                        }
                    }
                    .onEnded { gesture in
                        if gesture.translation.width < -geometry.size.width / 8 {
                            offset = geometry.size.width
                            nextView()
                        } else if gesture.translation.width > geometry.size.width / 8 {
                            offset = -geometry.size.width
                            prevView()
                        }
                        offset = 0.0
                        scaleFactor = 1.0
                        backgroundColor = Color.clear
                    }
            )
        }
    }
    private func nextView() {
        withAnimation {
            if isRaceTimerPresented {
                viewIndex = 0
                isRaceTimerPresented = false
            }
            else {
                viewIndex = viewIndex + 1
            }
            if viewIndex == views.count {
                isRaceTimerPresented = true
            }
        }
    }
    private func prevView() {
        withAnimation {
            backgroundColor = Color.gray
            if isRaceTimerPresented {
                viewIndex = views.count - 1
                isRaceTimerPresented = false
            }
            else {
                viewIndex = viewIndex - 1
            }
            if viewIndex == -1 {
                isRaceTimerPresented = true
            }
        }
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
