//
//  LocationManager.swift
//  Sailing
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
        print("location manager initialized")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        startLocationServices()
    }
    
    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            print("location manager is authorized")
            startTracking()
            isAuthorized = true
        } else {
            print("location manager is not authorized, requesting")
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
        print("Location Manager Error:", error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        if let location = locations.last {
            var newSpeed = location.speed > 0 ? location.speed : 0.0
            newSpeed = round(newSpeed * 10) / 10
            if (newSpeed != speed) {
                speed = newSpeed
                print("speed updated", "\(speed)")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let newMagneticHeading: Int = Int(round(newHeading.magneticHeading)) % 360
        if (Double(newMagneticHeading) != magneticHeading) {
            magneticHeading = Double(newMagneticHeading)
        }
        
        let newTrueHeading: Int = Int(round(newHeading.trueHeading)) % 360
        if (Double(newTrueHeading) != trueHeading) {
            trueHeading = Double(newTrueHeading)
        }
        heading = newHeading
        print("heading updated magneticHeading:", "\(magneticHeading)", "trueHeading:", "\(trueHeading)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("location manager authorization changed:", "\(manager.authorizationStatus)")
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            startLocationServices()
        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
            print("access denied")
        default:
            isAuthorized = true
            startLocationServices()
        }
    }
}

