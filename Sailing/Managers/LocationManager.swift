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
        print("\(Date().toTimestamp) - \(#file) \(#function) location manager initialized")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        startLocationServices()
    }
    
    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            print("\(Date().toTimestamp) - \(#file) \(#function) location manager is authorized")
            startTracking()
            isAuthorized = true
        } else {
            print("\(Date().toTimestamp) - \(#file) \(#function) location manager is not authorized, requesting")
            isAuthorized = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestAuthorization() {
        print("\(Date().toTimestamp) - \(#file) \(#function) requesting authorization")
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        print("\(Date().toTimestamp) - \(#file) \(#function) starting tracking")
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func stopTracking() {
        print("\(Date().toTimestamp) - \(#file) \(#function) stopping tracking")
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(Date().toTimestamp) - \(#file) \(#function) Location Manager Error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        if let location = locations.last {
            var newSpeed = location.speed > 0 ? location.speed : 0.0
            newSpeed = round(newSpeed * 10) / 10
            if (newSpeed != speed) {
                speed = newSpeed
                print("\(Date().toTimestamp) - \(#file) \(#function) speed updated \(speed)")
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
        print("\(Date().toTimestamp) - \(#file) \(#function) heading updated magneticHeading: \(magneticHeading), trueHeading: \(trueHeading)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("\(Date().toTimestamp) - \(#file) \(#function) location manager authorization changed \(manager.authorizationStatus)")
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            startLocationServices()
        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
            print("\(Date().toTimestamp) - \(#file) \(#function) access denied")
        default:
            isAuthorized = true
            startLocationServices()
        }
    }
}

