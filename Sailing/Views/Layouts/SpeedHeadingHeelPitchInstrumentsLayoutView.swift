//
//  SpeedHeadingHeelPitchLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct SpeedHeadingHeelPitchInstrumentsLayoutView: View {
    private let instruments: [AnyView] = [
        AnyView(SpeedView()),
        AnyView(HeadingView()),
        AnyView(Spacer()),
        AnyView(Spacer()),
        AnyView(HeelAngleView()),
        AnyView(PitchAngleView())
        ]

    var body: some View {
        InstrumentsLayoutView(instruments: instruments)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            SpeedHeadingHeelPitchInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
