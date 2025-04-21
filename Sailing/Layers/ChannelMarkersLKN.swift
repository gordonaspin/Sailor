//
//  ChannelMarkersLKN.swift
//  Sailing
//
//  Created by Gordon Aspin on 4/19/25.
//
import MapKit
import SwiftUI

struct Triangle: Shape {
    public init() {
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - rect.maxY / sqrt(3) /*rect.minX*/, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rect.maxY / sqrt(3) /*rect.maxX*/, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Square: Shape {
    public init() {
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}

enum MarkerShape {
    case square
    case triangle
}

struct ChannelMarker: NamedLocation, Identifiable {
    var id: UUID = UUID()
    var name: String
    var color: Color
    var shape: MarkerShape
    var coordinate: CLLocationCoordinate2D
}

struct ChannelMarkersLKN {
    let markers: [ChannelMarker] = [
        ChannelMarker(name: "1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.445498, longitude: -80.955495)),
        ChannelMarker(name: "1A", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.459001, longitude: -80.949299)),
        ChannelMarker(name: "3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.485004, longitude: -80.949798)),
        ChannelMarker(name: "3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.485004, longitude: -80.949798)),
        ChannelMarker(name: "7", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.515705, longitude: -80.960505)),
        ChannelMarker(name: "11", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.537098, longitude: -80.953403)),
        ChannelMarker(name: "13", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.553998, longitude: -80.956197)),
        ChannelMarker(name: "15", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.585599, longitude: -80.951997)),
        ChannelMarker(name: "15A", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.589102, longitude: -80.939198)),
        ChannelMarker(name: "17", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.594000, longitude: -80.936601)),
        ChannelMarker(name: "17A", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.599100, longitude: -80.941697)),
        ChannelMarker(name: "17B", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.615298, longitude: -80.938602)),
        ChannelMarker(name: "17C", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.616802, longitude: -80.932717)),
        ChannelMarker(name: "17D", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.621482, longitude: -80.928066)),
        ChannelMarker(name: "18B", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.627098, longitude: -80.924402)),
        ChannelMarker(name: "19", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.635299, longitude: -80.944605)),
        ChannelMarker(name: "21", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.660504, longitude: -80.962104)),
        ChannelMarker(name: "23", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.671199, longitude: -80.968600)),
        ChannelMarker(name: "25", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.690699, longitude: -80.986801)),
        ChannelMarker(name: "D1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.491197, longitude: -80.942996)),
        ChannelMarker(name: "D3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.493499, longitude: -80.935099)),
        ChannelMarker(name: "D5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.501400, longitude: -80.926602)),
        ChannelMarker(name: "D7", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.508099, longitude: -80.915605)),
        ChannelMarker(name: "D9", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.530288, longitude: -80.898707)),
        ChannelMarker(name: "D11", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.551301, longitude: -80.885103)),
        ChannelMarker(name: "L1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.463999, longitude: -80.974302)),
        ChannelMarker(name: "M1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.551598, longitude: -80.968498)),
        ChannelMarker(name: "M3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.560798, longitude: -80.980697)),
        ChannelMarker(name: "M5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.564101, longitude: -80.994800)),
        ChannelMarker(name: "P1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.46888889, longitude: -80.94583333)),
        ChannelMarker(name: "R1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.446599, longitude: -80.935700)),
        ChannelMarker(name: "R3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.453102, longitude: -80.918700)),
        ChannelMarker(name: "R5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.456799, longitude: -80.904999)),
        ChannelMarker(name: "T1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.513998, longitude: -80.900102)),
        ChannelMarker(name: "T3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.512898, longitude: -80.890102)),
        ChannelMarker(name: "T5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.515998, longitude: -80.876402)),
        ChannelMarker(name: "MC1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.589900, longitude: -80.927401)),
        ChannelMarker(name: "2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.468098, longitude: -80.949197)),
        ChannelMarker(name: "2A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.477399, longitude: -80.945501)),
        ChannelMarker(name: "4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.497303, longitude: -80.956804)),
        ChannelMarker(name: "4A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.502500, longitude: -80.960698)),
        ChannelMarker(name: "6", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.506998, longitude: -80.962200)),
        ChannelMarker(name: "8", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.529100, longitude: -80.954701)),
        ChannelMarker(name: "10", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.534199, longitude: -80.952802)),
        ChannelMarker(name: "12", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.547500, longitude: -80.956197)),
        ChannelMarker(name: "14", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.568199, longitude: -80.954599)),
        ChannelMarker(name: "16", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.582601, longitude: -80.943902)),
        ChannelMarker(name: "16A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.596299, longitude: -80.931800)),
        ChannelMarker(name: "18", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.613100, longitude: -80.932401)),
        ChannelMarker(name: "18A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.624599, longitude: -80.923297)),
        ChannelMarker(name: "20", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.651996, longitude: -80.955098)),
        ChannelMarker(name: "22", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.664601, longitude: -80.964802)),
        ChannelMarker(name: "24", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.681100, longitude: -80.979002)),
        ChannelMarker(name: "B2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.617173, longitude: -80.919322)),
        ChannelMarker(name: "D2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.482400, longitude: -80.940598)),
        ChannelMarker(name: "D4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.489800, longitude: -80.931602)),
        ChannelMarker(name: "D6", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.496600, longitude: -80.916399)),
        ChannelMarker(name: "D8", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.513601, longitude: -80.902902)),
        ChannelMarker(name: "D8A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.520801, longitude: -80.899898)),
        ChannelMarker(name: "D10", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.539298, longitude: -80.889899)),
        ChannelMarker(name: "H2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.649110, longitude: -80.931945)),
        ChannelMarker(name: "H4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.656900, longitude: -80.938302)),
        ChannelMarker(name: "M2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.559301, longitude: -80.971400)),
        ChannelMarker(name: "M4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.566602, longitude: -80.982102)),
        ChannelMarker(name: "P2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.46916667, longitude: -80.94444444)),
        ChannelMarker(name: "R2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.446704, longitude: -80.932095)),
        ChannelMarker(name: "R4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.445000, longitude: -80.912901)),
        ChannelMarker(name: "T2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.506597, longitude: -80.895799)),
        ChannelMarker(name: "T4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.510099, longitude: -80.883402)),
    ]
}
