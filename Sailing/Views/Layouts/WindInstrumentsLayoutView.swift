//
//  WindInstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct WindInstrumentsLayoutView: View {
    private let instruments: [AnyView] = [
        AnyView(SpeedView()),
        AnyView(HeadingView()),
        AnyView(WindSpeedView()),
        AnyView(WindDirectionView()),
        AnyView(ApparentWindSpeedView()),
        AnyView(ApparentWindAngleView())
    ]
    
    var body: some View {
        InstrumentsLayoutView(instruments: instruments)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            WindInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
