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
    @State var isRaceTimerPresented: Bool = false
    @State var viewIndex: Int = 0
    @State private var offset: CGFloat = 0
    @State private var backgroundColor: Color = .clear

    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                if !isRaceTimerPresented {
                    ZStack {
                        MapView()
                        views[viewIndex]
                            .animation(.easeInOut(duration: 2.0), value: offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation.width
                                        backgroundColor = Color.gray.opacity(0.5)
                                    }
                                    .onEnded { gesture in
                                        if gesture.predictedEndTranslation.width < -geometry.size.width / 8 {
                                            nextView()
                                        } else if gesture.predictedEndTranslation.width > geometry.size.width / 8 {
                                            prevView()
                                        } else {
                                            offset = 0
                                        }
                                        backgroundColor = Color.clear
                                    }
                            )
                            .background(backgroundColor)
                    }
                    .onAppear() {
                        print("\(Date().toTimestamp) -  \(#file) \(#function) Map & DefaultLayoutView onAppear, start tracking")
                        locationManager.startTracking()
                        motionManager.startTracking()
                    }
                }
                else {
                    RaceTimerView(isPresented: $isRaceTimerPresented, viewIndex: $viewIndex)
                        .animation(.easeInOut(duration: 2.0), value: offset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation.width
                                    backgroundColor = Color.gray.opacity(0.5)
                                }
                                .onEnded { gesture in
                                    if gesture.predictedEndTranslation.width < -geometry.size.width / 8 {
                                        nextView()
                                    } else if gesture.predictedEndTranslation.width > geometry.size.width / 8 {
                                        prevView()
                                    } else {
                                        offset = 0
                                    }
                                    backgroundColor = Color.clear
                                }
                        )
                        .background(backgroundColor)
                        .onAppear {
                            print("\(Date().toTimestamp) -  \(#file) \(#function) RaceTimerView onAppear, stop tracking")
                            locationManager.stopTracking()
                            motionManager.stopTracking()
                        }
                }
            }
            /*.swipe(
                left: {
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
                    print("swipe left : \(viewIndex) \(isRaceTimerPresented)")
                },
                right: {
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
                    print("swipe right : \(viewIndex) \(isRaceTimerPresented)")
                }
            )*/
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
