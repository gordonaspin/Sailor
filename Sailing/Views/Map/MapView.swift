//
//  MapView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(LocationManager.self) private var locationManager
    @StateObject private var settings = BoatHeadingSettings.shared
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    private var permanentMarks: PermanentMarksLKN = PermanentMarksLKN()
    private var channelMarkers: ChannelMarkersLKN = ChannelMarkersLKN()
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(permanentMarks.permanentMarks, id: \.id) { mark in
                Annotation(mark.name, coordinate: mark.coordinate) {
                    if mark.flag.isEmpty {
                        Square()
                            .fill(Color.white)
                    } else {
                        Image(String(mark.flag))
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                }
            }
            ForEach(channelMarkers.markers, id: \.id) { mark in
                Annotation(mark.name, coordinate: mark.coordinate) {
                    switch mark.shape {
                    case .square:
                        Square()
                            .fill(mark.color)
                    case .triangle:
                        Triangle()
                            .fill(mark.color)
                    }
                }
            }
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
        @StateObject private var settings = BoatHeadingSettings.shared
        var body: some View {
            MapView()
                .environment(LocationManager())
        }
    }
    return Preview()
}
