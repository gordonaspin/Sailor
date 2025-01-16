//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI
import MapKit

struct SailorView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = HeadingSettings.shared

    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
            }
            .mapControls( {
                MapCompass()
                    .mapControlVisibility(.automatic)
                MapScaleView()
                    .mapControlVisibility(.visible)

            })
            .onChange(of: locationManager.heading) {
                print("\(Date().toTimestamp) - onChange of heading \(String(describing: locationManager.heading))")
                cameraPosition = .userLocation(followsHeading: settings.mapFollowsHeading, fallback: .automatic)
            }
            GeometryReader { geometry in
                if geometry.size.height > geometry.size.width {
                    VStack(alignment: .center, spacing: 0) {
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
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            SailorView()
                .environment(LocationManager())
                .environment(MotionManager())
        }
    }
    return Preview()
}
