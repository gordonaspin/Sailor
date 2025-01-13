//
//  LocationManager.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import CoreLocation
import MapKit
import _MapKit_SwiftUI

//struct IdentifiableLocation: Identifiable {
//    let id: UUID
//    let coordinate: CLLocationCoordinate2D/
//}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    @Published var speed: Double = 0.0
    @Published var trueHeading: Int = 0
    @Published var magneticHeading: Int = 0
    //@Published var mapRegion = MKCoordinateRegion(
    //    center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    //    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    //)
    //@Published var mapBounds = MapCameraBounds(centerCoordinateBounds: MKCoordinateRegion(
    //    center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    //    span: MKCoordinateSpan(latitudeDelta: 1000, longitudeDelta: 1000)
    //))
    @Published var mapBounds: MapCameraBounds?

    //@Published var userLocation: IdentifiableLocation?
    @Published var userPosition: MapCameraPosition = .automatic

    private var locationManager = CLLocationManager()

    private override init() {
        print("LocationManager init calling super")
        super.init()
        print("LocationManager calling setupLocationManager")
        setupLocationManager()
    }

    func requestAuthorization() {
        print("requesting authorization")
        locationManager.requestWhenInUseAuthorization()
    }

    func startTracking() {
        print("starting tracking")
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()

    }
    
    func stopTracking() {
        print("stopping tracking")
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization status \(status)")
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startTracking()
        } else {
            print("Location authorization denied \(status)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.speed = location.speed > 0 ? location.speed : 0.0
            DispatchQueue.main.async {
                //self.userLocation = IdentifiableLocation(id: UUID(), coordinate: location.coordinate)
                self.userPosition = .userLocation(fallback: .automatic)
                //self.mapRegion = MKCoordinateRegion(
                //    center: location.coordinate,
                //    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                //self.mapBounds = MapCameraBounds(centerCoordinateBounds: MKCoordinateRegion(
                //    center: location.coordinate,
                //    span: MKCoordinateSpan(latitudeDelta: 1000, longitudeDelta: 1000)), minimumDistance: 5000, maximumDistance: 5000)
                let center = location.coordinate
                let regionRadius: CLLocationDistance = 16093.4 // 10 miles in meters

                let region = MKCoordinateRegion(
                 center: center,
                 latitudinalMeters: regionRadius * 2,
                 longitudinalMeters: regionRadius * 2
                )

                self.mapBounds = MapCameraBounds(
                 centerCoordinateBounds: region,
                 minimumDistance: nil,
                 maximumDistance: nil
                )
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.magneticHeading = Int(newHeading.magneticHeading)
        self.trueHeading = Int(newHeading.trueHeading)
    }
}
