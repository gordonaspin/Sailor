//
//  MapView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI
import MapKit


struct MapView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = HeadingSettings.shared
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
        .mapControls( {
            MapCompass()
                .mapControlVisibility(.visible)
                /*.on
                .onTapGesture {
                    print(">>>  \(Date().toTimestamp) - MapCompass onTapGesture")
                    settings.mapFollowsHeading.toggle()}*/
            MapScaleView()
                .mapControlVisibility(.visible)
            MapUserLocationButton()
                .mapControlVisibility(.visible)

        })
        /*.onChange(of: locationManager.heading) {
            print("\(Date().toTimestamp) - onChange of heading \(String(describing: locationManager.heading))")
            //cameraPosition = .userLocation(followsHeading: settings.mapFollowsHeading, fallback: .automatic)
        }*/
        .onAppear() {
            locationManager.startTracking()
        }
        .onDisappear {
            locationManager.stopTracking()
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            MapView()
                .environment(LocationManager())
        }
    }
    return Preview()
}
