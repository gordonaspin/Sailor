//
//  LocationManager.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    @Published var speed: Double = 0.0
    @Published var heading: Int = 0

    private var locationManager = CLLocationManager()

    private override init() {
        print("MotionalAndLocationManager init calling super")
        super.init()
        print("MotionalAndLocationManager calling setupLocationManager")
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
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager: location updated")
        if let location = locations.last {
            self.speed = location.speed > 0 ? location.speed : 0.0
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("localManager: heading updated")
        self.heading = Int(newHeading.magneticHeading)
    }
}
