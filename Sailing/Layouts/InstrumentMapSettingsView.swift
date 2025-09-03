//
//  InstrumentMapSettingsView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct InstrumentMapSettingsView: View {
    @Binding var instruments: [Instrument]
    public var instrumentSettings = InstrumentSettings()
    @Binding var showChannelMarkers: Bool
    @Binding var showPermanentMarks: Bool
    @Binding var showPointsOfInterest: Bool
    var body: some View {

        List {
            Section(header: Text("Instruments")) {
                ForEach($instruments) { $item in
                    HStack {
                        Text(item.instrumentName)
                        //.padding()
                        //    .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)

                        Toggle(isOn: $item.isEnabled) {
                        }
                        //.padding(.trailing, 8)
                        .onChange(of: item.isEnabled) {
                            updateInstruments()
                        }
                    }
                }
                .onMove(perform: move)
                //.listRowInsets(.init())
            }
            Section(header: Text("Layers")) {
                Toggle("Show Channel Markers", isOn: $showChannelMarkers)
                Toggle("Show Permanent Markers", isOn: $showPermanentMarks)
                Toggle("Show Points of Interest", isOn: $showPointsOfInterest)
            }
        }
        .listRowInsets(.init())
    }
    private func move(from source: IndexSet, to destination: Int) {
        print("move: \(source.startIndex) to \(destination)")
        instruments.move(fromOffsets: source, toOffset: destination)
        updateInstruments()
    }
    private func updateInstruments() {
        var instrumentStr = ""
        for instrument in instruments {
            instrumentStr += instrument.instrumentType + (instrument.isEnabled ? "T" : "F")
        }
        instrumentSettings.instrumentStr = instrumentStr
        print("updateInstruments: \(instrumentStr)")
        
    }
}

#Preview {
    struct Preview: View {
        @State private var instruments: [Instrument] = [
            Instrument(instrument: AnyView(BoatSpeedView()), isEnabled: true, instrumentType: "0", instrumentName: "Boat Speed"),
            Instrument(instrument: AnyView(BoatHeadingView()), isEnabled: true, instrumentType: "1", instrumentName: "Boat Heading"),
            Instrument(instrument: AnyView(WindSpeedView()), isEnabled: true, instrumentType: "2", instrumentName: "Wind Speed"),
            Instrument(instrument: AnyView(WindDirectionView()), isEnabled: true, instrumentType: "3", instrumentName: "Wind Direction"),
            Instrument(instrument: AnyView(ApparentWindSpeedView()), isEnabled: true, instrumentType: "4", instrumentName: "Apparent Wind Speed"),
            Instrument(instrument: AnyView(ApparentWindAngleView()), isEnabled: true, instrumentType: "5", instrumentName: "Apparent Wind Angle"),
            Instrument(instrument: AnyView(HeelAngleView()), isEnabled: true, instrumentType: "6", instrumentName: "Heel Angle"),
            Instrument(instrument: AnyView(PitchAngleView()), isEnabled: true, instrumentType: "7", instrumentName: "Pitch Angle")
        ]
        @State private var showChannelMarkers: Bool = true
        @State private var showPermanentMarks: Bool = true
        @State private var showPointsOfInterest: Bool = true
        @State private var mapSettings: MapSettings = MapSettings()
        var body: some View {
            InstrumentMapSettingsView(instruments: $instruments, showChannelMarkers: $showChannelMarkers, showPermanentMarks: $showPermanentMarks, showPointsOfInterest: $showPointsOfInterest)
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
