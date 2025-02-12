//
//  DefaultInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct DefaultInstrumentsLayoutView: View {
    private let instruments: [AnyView] = [
        AnyView(SpeedView()),
        AnyView(HeadingView()),
        AnyView(WindSpeedView()),
        AnyView(WindDirectionView()),
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
            DefaultInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
