//
//  SailingView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI
import AVFoundation

struct Instrument: Identifiable {
    let id = UUID()
    var instrument: AnyView
    var isEnabled: Bool
    var instrumentType: String
    var instrumentName: String
}

enum tabs : Int {
    case map = 0
    case race
    case timer
    case flags
    case settings
}

struct SailingView: View {
    @State private var instruments: [Instrument] = []
    @Environment(\.scenePhase) private var phase
    @Environment(LocationManager.self) private var locationManager
    @Environment(MotionManager.self) private var motionManager
    @Environment(WeatherManager.self) private var weatherManager
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var heelAngleSettings = HeelAngleSettings.shared
    @StateObject private var settings = Settings()
    @StateObject private var instrumentSettings = InstrumentSettings()
    @StateObject private var mapSettings = MapSettings()

    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    private let synthesizer = AVSpeechSynthesizer()
    @State var tabSelection: Int = 0
    private let fgColor: Color = Color(cgColor: CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 128))
    var body: some View {
        TabView (selection: $tabSelection) {
            Tab("Map", systemImage: "map.circle", value: tabs.map.rawValue) {
                ZStack {
                    MapView(showChannelMarkers: $mapSettings.showChannelMarkers, showPermanentMarks: $mapSettings.showPermanentMarks, showPointsOfInterest: $mapSettings.showPointsOfInterest)
                        .overlay(alignment: .bottomLeading) {
                            // Legal requirements (Apple logo and source link)
                            HStack(spacing: 0) {
                                Image(systemName: "apple.logo") // Use the Apple Weather logo asset
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(fgColor)
                                Text("Weather")
                                    .font(.system(size:14))
                                    .foregroundColor(fgColor)
                                    .padding(.bottom, -3)
                                Link(destination: URL(string: "https://weatherkit.apple.com/legal-attribution.html")!, label: {
                                    Text("Legal")
                                    .underline()})
                                .font(.system(size:9))
                                .foregroundColor(fgColor)
                                .padding(.leading, 5)
                                .padding(.bottom, -3)
                            }
                            .offset(x: 9.5, y: 0)
                        }
                }
            }
            Tab("Race", systemImage: "sailboat.circle", value: tabs.race.rawValue) {
                RaceInstrumentsLayoutView(instruments: $instruments)
                    .background(Color.black)
            }
            Tab("Timer", systemImage: "timer.circle", value: tabs.timer.rawValue) {
                RaceTimerView(tabSelection: $tabSelection)
            }
            Tab("Flags", systemImage: "flag.2.crossed.circle", value: tabs.flags.rawValue) {
                FlagView()
            }
            Tab("Settings", systemImage: "gear", value: tabs.settings.rawValue) {
                InstrumentMapSettingsView(instruments: $instruments, showChannelMarkers: $mapSettings.showChannelMarkers, showPermanentMarks: $mapSettings.showPermanentMarks, showPointsOfInterest: $mapSettings.showPointsOfInterest)
            }
        }
        .onAppear {
            instruments = loadInstruments()
        }
        .onChange(of: phase) {
            switch phase {
            case .active:
                print("active")
                timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
                locationManager.startTracking()
                motionManager.startTracking()
                //weatherManager.startTracking()
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
    func loadInstruments() -> [Instrument] {
        
        var instruments: [Instrument] = []
        for i in stride(from: 0, to: instrumentSettings.instrumentStr.count, by: 2) {
            if i + 1 < instrumentSettings.instrumentStr.count {
                let twoChars = String(instrumentSettings.instrumentStr[instrumentSettings.instrumentStr.index(instrumentSettings.instrumentStr.startIndex, offsetBy: i)...instrumentSettings.instrumentStr.index(instrumentSettings.instrumentStr.startIndex, offsetBy: i+1)])
                let typeStr = twoChars[0]
                let enabled = twoChars[1] == "T" ? true : false
                switch typeStr {
                case "0":
                    instruments.append(Instrument(instrument: AnyView(BoatSpeedView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Boat Speed"))
                case "1":
                    instruments.append(Instrument(instrument: AnyView(BoatHeadingView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Boat Heading"))
                case "2":
                    instruments.append(Instrument(instrument: AnyView(WindSpeedView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Wind Speed"))
                case "3":
                    instruments.append(Instrument(instrument: AnyView(WindDirectionView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Wind Direction"))
                case "4":
                    instruments.append(Instrument(instrument: AnyView(ApparentWindSpeedView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Apparent Wind Speed"))
                case "5":
                    instruments.append(Instrument(instrument: AnyView(ApparentWindAngleView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Apparent Wind Angle"))
                case "6":
                    instruments.append(Instrument(instrument: AnyView(HeelAngleView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Heel Angle"))
                case "7":
                    instruments.append(Instrument(instrument: AnyView(PitchAngleView()), isEnabled: enabled, instrumentType: typeStr, instrumentName: "Pitch Angle"))
                default:
                    continue
                }
            }
        }
        return instruments
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            SailingView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
                .environment(StopWatch())
        }
    }
    return Preview()
}
