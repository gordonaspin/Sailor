//
//  DefaultInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct RacingInstrumentsLayoutView: View {
    private let instruments: [AnyView] = [
        AnyView(BoatSpeedView()),
        AnyView(BoatHeadingView()),
        AnyView(WindSpeedView()),
        AnyView(WindDirectionView()),
        AnyView(ApparentWindAngleView()),
        AnyView(HeelAngleView()),
    ]
    var body: some View {
        InstrumentsLayoutView(instruments: instruments)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            RacingInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
