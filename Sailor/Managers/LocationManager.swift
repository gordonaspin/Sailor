//
//  LocationManager.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored let locationManager = CLLocationManager()
    
    var speed: Double = 0.0
    var trueHeading: Double = 0
    var magneticHeading: Double = 0
    var heading: CLHeading?
    var userLocation: CLLocation?
    var isAuthorized = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        startLocationServices()
    }
    
    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            startTracking()
            isAuthorized = true
        } else {
            isAuthorized = false
            locationManager.requestWhenInUseAuthorization()
        }
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

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        if let location = locations.last {
            speed = location.speed > 0 ? location.speed : 0.0
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        magneticHeading = newHeading.magneticHeading
        trueHeading = newHeading.trueHeading
        heading = newHeading
    }
}

