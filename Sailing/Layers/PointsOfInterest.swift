//
//  PointsOfInterest.swift
//  Sailing
//
//  Created by Gordon Aspin on 8/28/25.
//
import SwiftUI
import MapKit

struct PointOfInterest: NamedLocation, Identifiable {
    var id: UUID = UUID()
    var name: String
    var color: Color
    var image: Image
    var coordinate: CLLocationCoordinate2D
}

struct PointsOfInterestLKN {
    let markers: [PointOfInterest] = [
        PointOfInterest(name: "LNYC", color: .blue, image: Image(systemName: "sailboat.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.517179, longitude: -80.916743)),
        PointOfInterest(name: "SHPYC", color: .blue, image: Image(systemName: "sailboat.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.467805, longitude: -80.935958)),
        PointOfInterest(name: "LNSC", color: .blue, image: Image(systemName: "sailboat.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.466058, longitude: -80.967269)),
        PointOfInterest(name: "LNCS", color: .blue, image: Image(systemName: "sailboat.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.435797, longitude: -80.908945)),

        PointOfInterest(name: "Ramsey Creek", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.463995, longitude: -80.900566)),
        PointOfInterest(name: "Blythe Landing", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.435800, longitude: -80.907411)),
        PointOfInterest(name: "Beatty's Ford", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.482423, longitude: -80.956499)),
        PointOfInterest(name: "Little Creek", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.538664, longitude: -80.980320)),
        PointOfInterest(name: "Hager Creek", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.560871, longitude: -80.952151)),
        PointOfInterest(name: "Stumpy Creek", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.625720, longitude: -80.902784)),
        PointOfInterest(name: "Lake Norman State Park", color: .blue, image: Image(String("Boat Ramp")).resizable(), coordinate: CLLocationCoordinate2D(latitude: 35.654267, longitude: -80.938425)),

        PointOfInterest(name: "North Harbor Club", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.506233, longitude: -80.866868)),
        PointOfInterest(name: "Eddie's", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.566916, longitude: -80.865726)),
        PointOfInterest(name: "LakeHouse Wine Bar and Grill", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.515705, longitude: -80.960505)),
        PointOfInterest(name: "Hello Sailor!", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.487554, longitude: -80.888116)),
        PointOfInterest(name: "Toucan's Lakefront", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.608334, longitude: -80.937767)),
        PointOfInterest(name: "Blue Parrot", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.608755, longitude: -80.937705)),
        PointOfInterest(name: "Waterside Bar and Grill", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.695250, longitude: -80.994112)),
        PointOfInterest(name: "Landing Restaurant", color: .orange, image: Image(systemName: "fork.knife.circle.fill"), coordinate: CLLocationCoordinate2D(latitude: 35.569955, longitude: -80.990583)),
    ]
}

