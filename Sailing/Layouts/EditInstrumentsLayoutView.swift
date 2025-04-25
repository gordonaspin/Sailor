//
//  EditInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct EditInstrumentsLayoutView: View {
    @Binding var instruments: [Instrument]
    @StateObject private var instrumentSettings = InstrumentSettings()

    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                List {
                    ForEach($instruments) { $item in
                        ZStack {
                            item.instrument
                                .background(Color.clear)
                                .frame(width: geometry.size.width, height: geometry.size.height/CGFloat(instruments.count))
                            Toggle(isOn: $item.isEnabled) {
                            }
                            .onChange(of: item.isEnabled) {
                                updateInstruments()
                            }
                            .offset(x: geometry.size.width/4)
                        }
                    }
                    .onMove(perform: move)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.secondary)
                }
                .listStyle(.plain)
                .background(Color.secondary)
                .padding(0)
            }
            else {
                VStack {
                    Spacer()
                    Text("Use Portrait Mode")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
            }
        }
    }
    private func move(from source: IndexSet, to destination: Int) {
        print("move: \(source) to \(destination)")
        instruments.move(fromOffsets: source, toOffset: destination)
        updateInstruments()
    }
    private func updateInstruments() {
        var instrumentStr = ""
        for instrument in instruments {
            instrumentStr += instrument.instrumentType + (instrument.isEnabled ? "T" : "F")
        }
        instrumentSettings.instrumentStr = instrumentStr
    }
}

#Preview {
    struct Preview: View {
        @State private var instruments: [Instrument] = [
            Instrument(instrument: AnyView(BoatSpeedView()), isEnabled: true, instrumentType: "0"),
            Instrument(instrument: AnyView(BoatHeadingView()), isEnabled: true, instrumentType: "1"),
            Instrument(instrument: AnyView(WindSpeedView()), isEnabled: true, instrumentType: "2"),
            Instrument(instrument: AnyView(WindDirectionView()), isEnabled: true, instrumentType: "3"),
            Instrument(instrument: AnyView(ApparentWindSpeedView()), isEnabled: true, instrumentType: "4"),
            Instrument(instrument: AnyView(ApparentWindAngleView()), isEnabled: true, instrumentType: "5"),
            Instrument(instrument: AnyView(HeelAngleView()), isEnabled: true, instrumentType: "6"),
            Instrument(instrument: AnyView(PitchAngleView()), isEnabled: true, instrumentType: "7")
        ]
        var body: some View {
            EditInstrumentsLayoutView(instruments: $instruments)
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
