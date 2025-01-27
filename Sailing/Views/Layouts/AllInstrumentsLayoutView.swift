//
//  DefaultLayoutView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct AllInstrumentsLayoutView: View {
    @State private var instruments: [AnyView] = [
        AnyView(WindSpeedView()),
        AnyView(WindDirectionView()),
        AnyView(SpeedView()),
        AnyView(HeadingView()),
        AnyView(HeelAngleView()),
        AnyView(PitchAngleView())
        ]

    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(0..<instruments.count, id: \..self) { i in
                        instruments[i]
                            .frame(width: geometry.size.width, height: geometry.size.height/CGFloat(instruments.count))
                            //.frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
               }
            }
            else {
                VStack(alignment: .center, spacing: 11) {
                    ForEach(0..<instruments.count/2, id: \..self) { i in
                        HStack(alignment: .center, spacing: 0) {
                            instruments[i*2]
                                .frame(width: geometry.size.width/2, height: geometry.size.height/3)
                            instruments[i*2 + 1]
                                .frame(width: geometry.size.width/2, height: geometry.size.height/3)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            AllInstrumentsLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()
}
