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
    
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    private let synthesizer = AVSpeechSynthesizer()
    @State var tabSelection: Int = 0
    private let fgColor: Color = Color(cgColor: CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 128))
    var body: some View {
        GeometryReader { geometry in
            TabView (selection: $tabSelection) {
                Tab("Map", systemImage: "map.circle", value: 0) {
                    ZStack {
                        MapView()
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
                        InstrumentsLayoutView(instruments: $instruments)
                    }
                }
                Tab("Timer", systemImage: "timer.circle", value: 1) {
                    RaceTimerView(tabSelection: $tabSelection)
                }
                Tab("Flags", systemImage: "flag.2.crossed.circle", value: 2) {
                    FlagView()
                }
                Tab("Settings", systemImage: "gear", value: 3) {
                    EditInstrumentsLayoutView(instruments: $instruments)
                }
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
                switch twoChars {
                case "0T":
                    instruments.append(Instrument(instrument: AnyView(BoatSpeedView()), isEnabled: true, instrumentType: "0"))
                case "0F":
                    instruments.append(Instrument(instrument: AnyView(BoatSpeedView()), isEnabled: false, instrumentType: "0"))
                case "1T":
                    instruments.append(Instrument(instrument: AnyView(BoatHeadingView()), isEnabled: true, instrumentType: "1"))
                case "1F":
                    instruments.append(Instrument(instrument: AnyView(BoatHeadingView()), isEnabled: false, instrumentType: "1"))
                case "2T":
                    instruments.append(Instrument(instrument: AnyView(WindSpeedView()), isEnabled: true, instrumentType: "2"))
                case "2F":
                    instruments.append(Instrument(instrument: AnyView(WindSpeedView()), isEnabled: false, instrumentType: "2"))
                case "3T":
                    instruments.append(Instrument(instrument: AnyView(WindDirectionView()), isEnabled: true, instrumentType: "3"))
                case "3F":
                    instruments.append(Instrument(instrument: AnyView(WindDirectionView()), isEnabled: false, instrumentType: "3"))
                case "4T":
                    instruments.append(Instrument(instrument: AnyView(ApparentWindSpeedView()), isEnabled: true, instrumentType: "4"))
                case "4F":
                    instruments.append(Instrument(instrument: AnyView(ApparentWindSpeedView()), isEnabled: false, instrumentType: "4"))
                case "5T":
                    instruments.append(Instrument(instrument: AnyView(ApparentWindAngleView()), isEnabled: true, instrumentType: "5"))
                case "5F":
                    instruments.append(Instrument(instrument: AnyView(ApparentWindAngleView()), isEnabled: false, instrumentType: "5"))
                case "6T":
                    instruments.append(Instrument(instrument: AnyView(HeelAngleView()), isEnabled: true, instrumentType: "6"))
                case "6F":
                    instruments.append(Instrument(instrument: AnyView(HeelAngleView()), isEnabled: false, instrumentType: "6"))
                case "7T":
                    instruments.append(Instrument(instrument: AnyView(PitchAngleView()), isEnabled: true, instrumentType: "7"))
                case "7F":
                    instruments.append(Instrument(instrument: AnyView(PitchAngleView()), isEnabled: false, instrumentType: "7"))
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
