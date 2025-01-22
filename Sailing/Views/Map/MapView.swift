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
        .mapControls(
            {
                MapCompass()
                    .mapControlVisibility(.visible)
                MapScaleView()
                    .mapControlVisibility(.visible)
                MapUserLocationButton()
                    .mapControlVisibility(.visible)
            }
        )
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
