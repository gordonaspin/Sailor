//
//  BoatPhysicalInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct BoatPhysicalInstrumentsLayoutView: View {
    private let instruments: [AnyView] = [
        AnyView(BoatSpeedView()),
        AnyView(BoatHeadingView()),
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
            BoatPhysicalInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
