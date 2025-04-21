//
//  PermanentMarkerLayer.swift
//  Sailing
//
//  Created by Gordon Aspin on 4/19/25.
//
import MapKit

protocol NamedLocation {
    var id: UUID { get }
    var name: String { get }
    var coordinate: CLLocationCoordinate2D { get }
}

struct PermanentMark: NamedLocation, Identifiable {
    var id: UUID = UUID()
    var name: String
    var flag: String
    var coordinate: CLLocationCoordinate2D
}

struct PermanentMarksLKN {
    let permanentMarks: [PermanentMark] = [
        PermanentMark(name: "B", flag: "B", coordinate: CLLocationCoordinate2D(latitude: 35.438348, longitude: -80.958788)),
        PermanentMark(name: "C", flag: "C", coordinate: CLLocationCoordinate2D(latitude: 35.529502, longitude: -80.904222)),
        PermanentMark(name: "D1", flag: "D", coordinate: CLLocationCoordinate2D(latitude: 35.51222222, longitude: -80.86916667)),
        PermanentMark(name: "D2", flag: "D", coordinate: CLLocationCoordinate2D(latitude: 35.51055556, longitude: -80.86944444)),

        PermanentMark(name: "G", flag: "G", coordinate: CLLocationCoordinate2D(latitude: 35.531144, longitude: -80.948489)),
        PermanentMark(name: "R", flag: "R", coordinate: CLLocationCoordinate2D(latitude: 35.492682, longitude: -80.938747)),
        PermanentMark(name: "RP", flag: "", coordinate: CLLocationCoordinate2D(latitude: 35.51, longitude: -80.90861111)),
        PermanentMark(name: "X", flag: "X", coordinate: CLLocationCoordinate2D(latitude: 35.439117, longitude: -80.950018)),
        PermanentMark(name: "Y", flag: "Y", coordinate: CLLocationCoordinate2D(latitude: 35.491765, longitude: -80.961578)),
        PermanentMark(name: "Z", flag: "Z", coordinate: CLLocationCoordinate2D(latitude: 35.51444444, longitude: -80.89166667)),
    ]
}
