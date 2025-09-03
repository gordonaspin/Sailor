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
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Binding var showChannelMarkers: Bool
    @Binding var showPermanentMarks: Bool
    @Binding var showPointsOfInterest: Bool
    private let channelMarkers: ChannelMarkersLKN = ChannelMarkersLKN()
    private let permanentMarks: PermanentMarksLKN = PermanentMarksLKN()
    private let pointsOfInterest: PointsOfInterestLKN = PointsOfInterestLKN()
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            if showPermanentMarks {
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
            }
            if showChannelMarkers {
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
            if showPointsOfInterest {
                ForEach(pointsOfInterest.markers, id: \.id) { mark in
                    Annotation(mark.name, coordinate: mark.coordinate) {
                        mark.image.foregroundColor(mark.color)
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
        @State private var showChannelMarkers: Bool = true
        @State private var showPermanentMarks: Bool = true
        @State private var showPointsOfInterest: Bool = true
        var body: some View {
            MapView(showChannelMarkers: $showChannelMarkers, showPermanentMarks: $showPermanentMarks, showPointsOfInterest: $showPointsOfInterest)
                .environment(LocationManager())
        }
    }
    return Preview()
}
