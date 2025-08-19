//
//  InstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/27/25.
//

import SwiftUI

struct InstrumentsLayoutView: View {
    @Binding var instruments: [Instrument]
    
    var viewsEnabledCount: Int {
        print("viewsEnabledCount: \(instruments.filter(\.isEnabled).count)")
        return max(3, instruments.filter(\.isEnabled).count)
    }
    func heightDivisor(_ number: Int) -> Int {
        if number % 2 == 0 {
            return number / 2
        } else {
            return (number + 1) / 2
        }
    }
    // Breaks the instruments array into chunks of two
    var enabledInstrumentsByRow: [[Instrument]] {
        var result: [[Instrument]] = []
        var temp: [Instrument] = []
        
        for view in instruments.filter(\.isEnabled) {
            temp.append(view)
            if temp.count == 2 {
                result.append(temp)
                temp = []
            }
        }
        // Add remaining view if the count is odd
        if !temp.isEmpty {
            result.append(temp)
        }
        
        return result
    }
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(0..<instruments.count, id: \..self) { i in
                        if instruments[i].isEnabled {
                            instruments[i].instrument
                                .frame(width: geometry.size.width, height: geometry.size.height/CGFloat(viewsEnabledCount))
                        }
                    }
                }
            }
            else {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<enabledInstrumentsByRow.count, id: \..self) { rowIndex in
                        HStack(alignment: .center, spacing: 0) {
                            if enabledInstrumentsByRow[rowIndex].count > 0 {
                                enabledInstrumentsByRow[rowIndex][0].instrument
                                    .frame(width: geometry.size.width/2, height: geometry.size.height/CGFloat(heightDivisor(viewsEnabledCount)))
                            }
                            if enabledInstrumentsByRow[rowIndex].count > 1 {
                                enabledInstrumentsByRow[rowIndex][1].instrument
                                    .frame(width: geometry.size.width/2, height: geometry.size.height/CGFloat(heightDivisor(viewsEnabledCount)))
                            }
                            
                        }
                    }
                }
            }
        }
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
            InstrumentsLayoutView(instruments: $instruments)
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
