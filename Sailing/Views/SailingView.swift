//
//  SailingView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI
import AVFoundation

struct SailingView: View {
    @State private var views: [AnyView] = [
        AnyView(DefaultInstrumentsLayoutView()),
        AnyView(WindInstrumentsLayoutView()),
        AnyView(SpeedHeadingHeelPitchInstrumentsLayoutView()),
        AnyView(SpeedHeadingInstrumentsLayoutView())
    ]
    @Environment(\.scenePhase) private var phase
    @Environment(LocationManager.self) var locationManager
    @Environment(MotionManager.self) var motionManager
    @Environment(WeatherManager.self) var weatherManager
    @Environment(\.colorScheme) var colorScheme
    @State private var isRaceTimerPresented: Bool = false
    @State private var viewIndex: Int = 0
    @State private var offset: CGFloat = 0.0
    @State private var backgroundColor: Color = .clear
    @State private var scaleFactor: CGFloat = 1
    @StateObject private var heelAngleSettings = HeelAngleSettings.shared
    @GestureState private var dragGestureActive: Bool = false
    @State var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                MapView()
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            isRaceTimerPresented.toggle()
                        } label: {
                            Image(systemName: "timer.circle")
                                .foregroundColor(.blue)
                                .background(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white)
                                .clipShape(Circle()) // Makes the background round
                                .frame(width: 40, height: 40)
                                .font(.system(size: 40))
                                .offset(
                                    x: (geometry.size.height > geometry.size.width) ? -7 : -5,
                                    y: (geometry.size.height > geometry.size.width) ? +5 : 15)
                                
                        }
                    }
                    .overlay(alignment: .bottomLeading) {
                        // Legal requirements (Apple logo and source link)
                        HStack(spacing: 0) {
                            Image(systemName: "apple.logo") // Use the Apple Weather logo asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 13, height: 13)
                            Text("Weather")
                                .font(.system(size:16))
                                .bold()
                                .padding(.bottom, -3)
                            Link(destination: URL(string: "https://weatherkit.apple.com/legal-attribution.html")!, label: {
                                Text("Legal")
                                .underline()})
                            .font(.system(size:9))
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                                .padding(.bottom, -3)
                        }
                        .offset(x: 9, y: 8)
                    }
                if !isRaceTimerPresented {
                    views[viewIndex]
                        .offset(x: offset)
                        .scaleEffect(scaleFactor)
                        .background(backgroundColor)
                }
                else {
                    RaceTimerView(isPresented: $isRaceTimerPresented)
                        .offset(x: offset)
                        .scaleEffect(scaleFactor)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                }
            }
            .animation(.spring(), value: offset)
            .onChange(of: dragGestureActive) {
                if dragGestureActive == false {
                    offset = .zero
                    scaleFactor = 1.0
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragGestureActive) { value, state, transaction in
                        state = true
                    }
                    .onChanged { gesture in
                        offset = gesture.translation.width
                        if abs(gesture.translation.width) > geometry.size.width / 8 {
                            backgroundColor = Color.gray.opacity(0.5)
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
                        offset = .zero
                        scaleFactor = 1.0
                        backgroundColor = Color.clear
                    }
            )
        }
        .onChange(of: phase) {
            switch phase {
            case .active:
                print("active")
                timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                locationManager.startTracking()
                motionManager.startTracking()
                weatherManager.startTracking()
            case .inactive:
                print("inactive")
                timer.upstream.connect().cancel()
                locationManager.stopTracking()
                motionManager.stopTracking()
                weatherManager.stopTracking()
            case .background:
                print("background")
            @unknown default:
                break
            }
        }
        .onReceive(timer) { _ in
            if (heelAngleSettings.speakHeelAlarms) {
                let heel = abs(HeelAngleView.convertHeel(
                    rollAngle: motionManager.rollAngle,
                    yawAngle: motionManager.yawAngle)
                )
                print("heel check timer fired, heel:", "\(heel)")
                if (heel < heelAngleSettings.optimumHeelAngle - 5) {
                    synthesizer.speak(AVSpeechUtterance(string: heelAngleSettings.underHeelAlarm))
                }
                else if (heel > heelAngleSettings.optimumHeelAngle + 5) {
                    synthesizer.speak(AVSpeechUtterance(string: heelAngleSettings.overHeelAlarm))
                }
            }
        }
    }
    private func nextView() {
        withAnimation {
            if isRaceTimerPresented {
                isRaceTimerPresented.toggle()
            }
            else {
                viewIndex = (viewIndex + 1) % views.count
            }
        }
    }
    private func prevView() {
        withAnimation {
            if isRaceTimerPresented {
                isRaceTimerPresented.toggle()
            }
            else {
                viewIndex = (viewIndex - 1 + views.count) % views.count
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            SailingView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
                .environment(StopWatch(countDown: CountDown.shared))
                .environment(CountDown())
        }
    }
    return Preview()
}
