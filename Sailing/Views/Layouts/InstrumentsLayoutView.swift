//
//  InstrumentsLayoutView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/27/25.
//

import SwiftUI

struct InstrumentsLayoutView: View {
    let instruments: [AnyView]

    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(0..<instruments.count, id: \..self) { i in
                        instruments[i]
                            .frame(width: geometry.size.width, height: geometry.size.height/CGFloat(instruments.count))
                    }
               }
            }
            else {
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    ForEach(0..<instruments.count/2, id: \..self) { i in
                        HStack(alignment: .center, spacing: 0) {
                            instruments[i*2]
                                .frame(width: geometry.size.width/2, height: geometry.size.height/CGFloat(instruments.count/2))
                            instruments[i*2 + 1]
                                .frame(width: geometry.size.width/2, height: geometry.size.height/CGFloat(instruments.count/2))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var instruments: [AnyView] = [
            AnyView(WindSpeedView()),
            AnyView(WindDirectionView()),
            AnyView(BoatSpeedView()),
            AnyView(BoatHeadingView()),
            //AnyView(HeelAngleView()),
            //AnyView(PitchAngleView()),
            //AnyView(ApparentWindSpeedView()),
            //AnyView(ApparentWindAngleView())
            ]
        var body: some View {
            InstrumentsLayoutView(instruments: instruments)
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
