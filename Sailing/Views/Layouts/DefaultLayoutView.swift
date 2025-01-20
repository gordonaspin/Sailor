//
//  DefaultLayoutView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct DefaultLayoutView: View {
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(alignment: .center, spacing: 0) {
                    WindSpeedView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    WindDirectionView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    SpeedView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    HeadingView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    HeelAngleView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    PitchAngleView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            else {
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        WindSpeedView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        WindDirectionView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    HStack(alignment: .center, spacing: 0) {
                        SpeedView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        HeadingView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    HStack(alignment: .center, spacing: 0){
                        HeelAngleView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        PitchAngleView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
            DefaultLayoutView()
                .environment(LocationManager())
                .environment(MotionManager())
                .environment(WeatherManager())
        }
    }
    return Preview()}
