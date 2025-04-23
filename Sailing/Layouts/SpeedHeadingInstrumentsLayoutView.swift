//
//  SpeedHeadingInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct SpeedHeadingInstrumentsLayoutView: View {
    private let instruments: [AnyView] = [
        AnyView(BoatSpeedView()),
        AnyView(BoatHeadingView()),
        AnyView(Spacer()),
        AnyView(Spacer())
        ]
    var body: some View {
        InstrumentsLayoutView(instruments: instruments)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            SpeedHeadingInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
