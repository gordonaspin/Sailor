//
//  MapView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI
import MapKit

struct PermanentMarker: Identifiable {
    var id: String {
        self.name
    }
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct MapView: View {
    @Environment(LocationManager.self) private var locationManager
    @StateObject private var settings = BoatHeadingSettings.shared
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    let permanentMarks: [PermanentMarker] = [
        PermanentMarker(name: "B", coordinate: CLLocationCoordinate2D(latitude: 35.438348, longitude: -80.958788)),
        PermanentMarker(name: "C", coordinate: CLLocationCoordinate2D(latitude: 35.529502, longitude: -80.904222)),
        PermanentMarker(name: "D", coordinate: CLLocationCoordinate2D(latitude: 35.512531, longitude: -80.873559)),
        PermanentMarker(name: "G", coordinate: CLLocationCoordinate2D(latitude: 35.531144, longitude: -80.948489)),
        PermanentMarker(name: "R", coordinate: CLLocationCoordinate2D(latitude: 35.492682, longitude: -80.938747)),
        PermanentMarker(name: "X", coordinate: CLLocationCoordinate2D(latitude: 35.439117, longitude: -80.950018)),
        PermanentMarker(name: "Y", coordinate: CLLocationCoordinate2D(latitude: 35.491765, longitude: -80.961578)),
        PermanentMarker(name: "Z", coordinate: CLLocationCoordinate2D(latitude: 35.514474, longitude: -80.893632))
    ]
    let greenChannelMarkers: [PermanentMarker] = [
        PermanentMarker(name: "1", coordinate: CLLocationCoordinate2D(latitude: 35.445498, longitude: -80.955495)),
        PermanentMarker(name: "1A", coordinate: CLLocationCoordinate2D(latitude: 35.459001, longitude: -80.949299)),
        PermanentMarker(name: "3", coordinate: CLLocationCoordinate2D(latitude: 35.485004, longitude: -80.949798)),
        PermanentMarker(name: "3", coordinate: CLLocationCoordinate2D(latitude: 35.485004, longitude: -80.949798)),
        PermanentMarker(name: "7", coordinate: CLLocationCoordinate2D(latitude: 35.515705, longitude: -80.960505)),
        PermanentMarker(name: "11", coordinate: CLLocationCoordinate2D(latitude: 35.537098, longitude: -80.953403)),
        PermanentMarker(name: "13", coordinate: CLLocationCoordinate2D(latitude: 35.553998, longitude: -80.956197)),
        PermanentMarker(name: "15", coordinate: CLLocationCoordinate2D(latitude: 35.585599, longitude: -80.951997)),
        PermanentMarker(name: "15A", coordinate: CLLocationCoordinate2D(latitude: 35.589102, longitude: -80.939198)),
        PermanentMarker(name: "17", coordinate: CLLocationCoordinate2D(latitude: 35.594000, longitude: -80.936601)),
        PermanentMarker(name: "17A", coordinate: CLLocationCoordinate2D(latitude: 35.599100, longitude: -80.941697)),
        PermanentMarker(name: "17B", coordinate: CLLocationCoordinate2D(latitude: 35.615298, longitude: -80.938602)),
        PermanentMarker(name: "17C", coordinate: CLLocationCoordinate2D(latitude: 35.616802, longitude: -80.932717)),
        PermanentMarker(name: "17D", coordinate: CLLocationCoordinate2D(latitude: 35.621482, longitude: -80.928066)),
        PermanentMarker(name: "18B", coordinate: CLLocationCoordinate2D(latitude: 35.627098, longitude: -80.924402)),
        PermanentMarker(name: "19", coordinate: CLLocationCoordinate2D(latitude: 35.635299, longitude: -80.944605)),
        PermanentMarker(name: "21", coordinate: CLLocationCoordinate2D(latitude: 35.660504, longitude: -80.962104)),
        PermanentMarker(name: "23", coordinate: CLLocationCoordinate2D(latitude: 35.671199, longitude: -80.968600)),
        PermanentMarker(name: "25", coordinate: CLLocationCoordinate2D(latitude: 35.690699, longitude: -80.986801)),
        PermanentMarker(name: "D1", coordinate: CLLocationCoordinate2D(latitude: 35.491197, longitude: -80.942996)),
        PermanentMarker(name: "D3", coordinate: CLLocationCoordinate2D(latitude: 35.493499, longitude: -80.935099)),
        PermanentMarker(name: "D5", coordinate: CLLocationCoordinate2D(latitude: 35.501400, longitude: -80.926602)),
        PermanentMarker(name: "D7", coordinate: CLLocationCoordinate2D(latitude: 35.508099, longitude: -80.915605)),
        PermanentMarker(name: "D9", coordinate: CLLocationCoordinate2D(latitude: 35.530288, longitude: -80.898707)),
        PermanentMarker(name: "D11", coordinate: CLLocationCoordinate2D(latitude: 35.551301, longitude: -80.885103)),
        PermanentMarker(name: "L1", coordinate: CLLocationCoordinate2D(latitude: 35.463999, longitude: -80.974302)),
        PermanentMarker(name: "M1", coordinate: CLLocationCoordinate2D(latitude: 35.551598, longitude: -80.968498)),
        PermanentMarker(name: "M3", coordinate: CLLocationCoordinate2D(latitude: 35.560798, longitude: -80.980697)),
        PermanentMarker(name: "M5", coordinate: CLLocationCoordinate2D(latitude: 35.564101, longitude: -80.994800)),
        PermanentMarker(name: "R1", coordinate: CLLocationCoordinate2D(latitude: 35.446599, longitude: -80.935700)),
        PermanentMarker(name: "R3", coordinate: CLLocationCoordinate2D(latitude: 35.453102, longitude: -80.918700)),
        PermanentMarker(name: "R5", coordinate: CLLocationCoordinate2D(latitude: 35.456799, longitude: -80.904999)),
        PermanentMarker(name: "T1", coordinate: CLLocationCoordinate2D(latitude: 35.513998, longitude: -80.900102)),
        PermanentMarker(name: "T3", coordinate: CLLocationCoordinate2D(latitude: 35.512898, longitude: -80.890102)),
        PermanentMarker(name: "T5", coordinate: CLLocationCoordinate2D(latitude: 35.515998, longitude: -80.876402)),
        PermanentMarker(name: "MC1", coordinate: CLLocationCoordinate2D(latitude: 35.589900, longitude: -80.927401)),
    ]
    let redChannelMarkers: [PermanentMarker] = [
        PermanentMarker(name: "2", coordinate: CLLocationCoordinate2D(latitude: 35.468098, longitude: -80.949197)),
        PermanentMarker(name: "2A", coordinate: CLLocationCoordinate2D(latitude: 35.477399, longitude: -80.945501)),
        PermanentMarker(name: "4", coordinate: CLLocationCoordinate2D(latitude: 35.497303, longitude: -80.956804)),
        PermanentMarker(name: "4A", coordinate: CLLocationCoordinate2D(latitude: 35.502500, longitude: -80.960698)),
        PermanentMarker(name: "6", coordinate: CLLocationCoordinate2D(latitude: 35.506998, longitude: -80.962200)),
        PermanentMarker(name: "8", coordinate: CLLocationCoordinate2D(latitude: 35.529100, longitude: -80.954701)),
        PermanentMarker(name: "10", coordinate: CLLocationCoordinate2D(latitude: 35.534199, longitude: -80.952802)),
        PermanentMarker(name: "12", coordinate: CLLocationCoordinate2D(latitude: 35.547500, longitude: -80.956197)),
        PermanentMarker(name: "14", coordinate: CLLocationCoordinate2D(latitude: 35.568199, longitude: -80.954599)),
        PermanentMarker(name: "16", coordinate: CLLocationCoordinate2D(latitude: 35.582601, longitude: -80.943902)),
        PermanentMarker(name: "16A", coordinate: CLLocationCoordinate2D(latitude: 35.596299, longitude: -80.931800)),
        PermanentMarker(name: "18", coordinate: CLLocationCoordinate2D(latitude: 35.613100, longitude: -80.932401)),
        PermanentMarker(name: "18A", coordinate: CLLocationCoordinate2D(latitude: 35.624599, longitude: -80.923297)),
        PermanentMarker(name: "20", coordinate: CLLocationCoordinate2D(latitude: 35.651996, longitude: -80.955098)),
        PermanentMarker(name: "22", coordinate: CLLocationCoordinate2D(latitude: 35.664601, longitude: -80.964802)),
        PermanentMarker(name: "24", coordinate: CLLocationCoordinate2D(latitude: 35.681100, longitude: -80.979002)),
        PermanentMarker(name: "B2", coordinate: CLLocationCoordinate2D(latitude: 35.617173, longitude: -80.919322)),
        PermanentMarker(name: "D2", coordinate: CLLocationCoordinate2D(latitude: 35.482400, longitude: -80.940598)),
        PermanentMarker(name: "D4", coordinate: CLLocationCoordinate2D(latitude: 35.489800, longitude: -80.931602)),
        PermanentMarker(name: "D6", coordinate: CLLocationCoordinate2D(latitude: 35.496600, longitude: -80.916399)),
        PermanentMarker(name: "D8", coordinate: CLLocationCoordinate2D(latitude: 35.513601, longitude: -80.902902)),
        PermanentMarker(name: "D8A", coordinate: CLLocationCoordinate2D(latitude: 35.520801, longitude: -80.899898)),
        PermanentMarker(name: "D10", coordinate: CLLocationCoordinate2D(latitude: 35.539298, longitude: -80.889899)),
        PermanentMarker(name: "H2", coordinate: CLLocationCoordinate2D(latitude: 35.649110, longitude: -80.931945)),
        PermanentMarker(name: "H4", coordinate: CLLocationCoordinate2D(latitude: 35.656900, longitude: -80.938302)),
        PermanentMarker(name: "M2", coordinate: CLLocationCoordinate2D(latitude: 35.559301, longitude: -80.971400)),
        PermanentMarker(name: "M4", coordinate: CLLocationCoordinate2D(latitude: 35.566602, longitude: -80.982102)),
        PermanentMarker(name: "R2", coordinate: CLLocationCoordinate2D(latitude: 35.446704, longitude: -80.932095)),
        PermanentMarker(name: "R4", coordinate: CLLocationCoordinate2D(latitude: 35.445000, longitude: -80.912901)),
        PermanentMarker(name: "T2", coordinate: CLLocationCoordinate2D(latitude: 35.506597, longitude: -80.895799)),
        PermanentMarker(name: "T4", coordinate: CLLocationCoordinate2D(latitude: 35.510099, longitude: -80.883402)),

    ]
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(permanentMarks, id: \.name) { mark in
                Annotation(mark.name, coordinate: mark.coordinate) {
                    Image(String(mark.name))
                        .resizable()
                        .frame(width: 16, height: 16)
                        .disabled(true)
                }
            }
            ForEach(greenChannelMarkers, id: \.name) { mark in
                Annotation("", coordinate: mark.coordinate) {
                    Text(String(mark.name))
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .background(.green)
                        .disabled(true)
                }
            }
            ForEach(redChannelMarkers, id: \.name) { mark in
                Annotation("", coordinate: mark.coordinate) {
                    ZStack {
                        Triangle()
                            .fill(Color.red)
                        Text(String(mark.name))
                            .font(.subheadline)
                            .foregroundColor(.white)
                            //.background(.red)
                            .disabled(true)
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
