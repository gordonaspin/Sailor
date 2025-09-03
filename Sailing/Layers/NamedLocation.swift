//
//  NamedLocation.swift
//  Sailing
//
//  Created by Gordon Aspin on 8/28/25.
//
import MapKit

protocol NamedLocation {
    var id: UUID { get }
    var name: String { get }
    var coordinate: CLLocationCoordinate2D { get }
}
