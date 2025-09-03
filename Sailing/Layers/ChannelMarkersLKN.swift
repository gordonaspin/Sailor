//
//  ChannelMarkersLKN.swift
//  Sailing
//
//  Created by Gordon Aspin on 4/19/25.
//
import MapKit
import SwiftUI

struct Marker: NamedLocation, Identifiable {
    var id: UUID = UUID()
    var name: String
    var color: Color
    var shape: MarkerShape
    var coordinate: CLLocationCoordinate2D
}

struct ChannelMarkersLKN {
    let markers: [Marker] = [
        Marker(name: "1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.445498, longitude: -80.955495)),
        Marker(name: "1A", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.459001, longitude: -80.949299)),
        Marker(name: "3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.485004, longitude: -80.949798)),
        Marker(name: "3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.485004, longitude: -80.949798)),
        Marker(name: "7", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.515705, longitude: -80.960505)),
        Marker(name: "11", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.537098, longitude: -80.953403)),
        Marker(name: "13", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.553998, longitude: -80.956197)),
        Marker(name: "15", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.585599, longitude: -80.951997)),
        Marker(name: "15A", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.589102, longitude: -80.939198)),
        Marker(name: "17", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.594000, longitude: -80.936601)),
        Marker(name: "17A", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.599100, longitude: -80.941697)),
        Marker(name: "17B", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.615298, longitude: -80.938602)),
        Marker(name: "17C", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.616802, longitude: -80.932717)),
        Marker(name: "17D", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.621482, longitude: -80.928066)),
        Marker(name: "18B", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.627098, longitude: -80.924402)),
        Marker(name: "19", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.635299, longitude: -80.944605)),
        Marker(name: "21", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.660504, longitude: -80.962104)),
        Marker(name: "23", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.671199, longitude: -80.968600)),
        Marker(name: "25", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.690699, longitude: -80.986801)),
        Marker(name: "D1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.491197, longitude: -80.942996)),
        Marker(name: "D3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.493499, longitude: -80.935099)),
        Marker(name: "D5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.501400, longitude: -80.926602)),
        Marker(name: "D7", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.508099, longitude: -80.915605)),
        Marker(name: "D9", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.530288, longitude: -80.898707)),
        Marker(name: "D11", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.551301, longitude: -80.885103)),
        Marker(name: "L1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.463999, longitude: -80.974302)),
        Marker(name: "M1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.551598, longitude: -80.968498)),
        Marker(name: "M3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.560798, longitude: -80.980697)),
        Marker(name: "M5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.564101, longitude: -80.994800)),
        Marker(name: "P1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.46888889, longitude: -80.94583333)),
        Marker(name: "R1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.446599, longitude: -80.935700)),
        Marker(name: "R3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.453102, longitude: -80.918700)),
        Marker(name: "R5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.456799, longitude: -80.904999)),
        Marker(name: "T1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.513998, longitude: -80.900102)),
        Marker(name: "T3", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.512898, longitude: -80.890102)),
        Marker(name: "T5", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.515998, longitude: -80.876402)),
        Marker(name: "MC1", color: .green, shape: MarkerShape.square, coordinate: CLLocationCoordinate2D(latitude: 35.589900, longitude: -80.927401)),
        Marker(name: "2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.468098, longitude: -80.949197)),
        Marker(name: "2A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.477399, longitude: -80.945501)),
        Marker(name: "4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.497303, longitude: -80.956804)),
        Marker(name: "4A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.502500, longitude: -80.960698)),
        Marker(name: "6", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.506998, longitude: -80.962200)),
        Marker(name: "8", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.529100, longitude: -80.954701)),
        Marker(name: "10", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.534199, longitude: -80.952802)),
        Marker(name: "12", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.547500, longitude: -80.956197)),
        Marker(name: "14", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.568199, longitude: -80.954599)),
        Marker(name: "16", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.582601, longitude: -80.943902)),
        Marker(name: "16A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.596299, longitude: -80.931800)),
        Marker(name: "18", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.613100, longitude: -80.932401)),
        Marker(name: "18A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.624599, longitude: -80.923297)),
        Marker(name: "20", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.651996, longitude: -80.955098)),
        Marker(name: "22", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.664601, longitude: -80.964802)),
        Marker(name: "24", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.681100, longitude: -80.979002)),
        Marker(name: "B2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.617173, longitude: -80.919322)),
        Marker(name: "D2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.482400, longitude: -80.940598)),
        Marker(name: "D4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.489800, longitude: -80.931602)),
        Marker(name: "D6", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.496600, longitude: -80.916399)),
        Marker(name: "D8", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.513601, longitude: -80.902902)),
        Marker(name: "D8A", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.520801, longitude: -80.899898)),
        Marker(name: "D10", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.539298, longitude: -80.889899)),
        Marker(name: "H2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.649110, longitude: -80.931945)),
        Marker(name: "H4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.656900, longitude: -80.938302)),
        Marker(name: "M2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.559301, longitude: -80.971400)),
        Marker(name: "M4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.566602, longitude: -80.982102)),
        Marker(name: "P2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.46916667, longitude: -80.94444444)),
        Marker(name: "R2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.446704, longitude: -80.932095)),
        Marker(name: "R4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.445000, longitude: -80.912901)),
        Marker(name: "T2", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.506597, longitude: -80.895799)),
        Marker(name: "T4", color: .red, shape: MarkerShape.triangle, coordinate: CLLocationCoordinate2D(latitude: 35.510099, longitude: -80.883402)),
    ]
}
