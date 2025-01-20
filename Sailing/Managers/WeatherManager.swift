//
//  WeatherManager.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/19/25.
//

import Foundation
import WeatherKit
import CoreLocation

@Observable
class WeatherManager: NSObject, CLLocationManagerDelegate {
    private let weatherManager = WeatherService()
    private let locationManager = CLLocationManager()
    
    var windSpeed: Double = 0.0
    var windDirection: Double = 0.0
    var isAuthorized = false

    override init() {
        super.init()
        print("\(Date().toTimestamp) -  \(#file) \(#function) weather manager initialized")
        locationManager.delegate = self
        startLocationServices()

        //locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
    }
    
    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            print("\(Date().toTimestamp) -  \(#file) \(#function) location manager is authorized")
            startTracking()
            isAuthorized = true
        } else {
            print("\(Date().toTimestamp) -  \(#file) \(#function) location manager is not authorized, requesting")
            isAuthorized = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startTracking() {
        print("\(Date().toTimestamp) -  \(#file) \(#function) starting tracking")
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        print("\(Date().toTimestamp) -  \(#file) \(#function) stopping tracking")
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("\(Date().toTimestamp) -  \(#file) \(#function) location manager authorization changed \(manager.authorizationStatus)")
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            startLocationServices()
        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
            print("\(Date().toTimestamp) -  \(#file) access denied")
        default:
            isAuthorized = true
            startLocationServices()
        }
    }
    
    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherManager.weather(for: location)

            let newWindSpeed = round((weather.currentWeather.wind.speed.value > 0 ? weather.currentWeather.wind.speed.value : 0.0) * 10) / 10
            if (newWindSpeed != windSpeed) {
                windSpeed = newWindSpeed
            }
            
            let newWindDirection: Int = Int(round(weather.currentWeather.wind.direction.value)) % 360
            if (Double(newWindDirection) != windDirection) {
                windDirection = Double(newWindDirection)
            }
            print("\(Date().toTimestamp) -  \(#file) \(#function) weather updated windSpeed: \(windSpeed), windDirection: \(windDirection)")
        }
        catch {
            print("\(Date().toTimestamp) -  \(#file) \(#function) failed to fetch weather: \(error)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Task {
            await fetchWeather(for: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(Date().toTimestamp) - \(#file) \(#function) weather error: \(error.localizedDescription)")
    }
}

