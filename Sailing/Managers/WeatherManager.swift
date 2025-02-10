//
//  WeatherManager.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/19/25.
//

import Foundation
import WeatherKit
import CoreLocation

@Observable
class WeatherManager: NSObject, CLLocationManagerDelegate {
    private let fiveMinutes: TimeInterval = 5 * 60
    private let weatherManager = WeatherService()
    private let locationManager = CLLocationManager()
    var windSpeed: Double = 0.0
    var windDirection: Double = 0.0
    var isAuthorized = false

    override init() {
        super.init()
        print("weather manager initialized")
        locationManager.delegate = self
        startLocationServices()
        _ = Timer.scheduledTimer(withTimeInterval: fiveMinutes, repeats: true) { _ in
            self.startTracking()
        }
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
    
    func startTracking() {
        print("starting tracking")
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        print("stopping tracking")
        locationManager.stopUpdatingLocation()
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
    
    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherManager.weather(for: location)
            let newWindSpeed = round((weather.currentWeather.wind.speed.value > 0 ? weather.currentWeather.wind.speed.value : 0.0) * 10) / 10
            windSpeed = newWindSpeed
            
            let newWindDirection: Int = Int(round(weather.currentWeather.wind.direction.value)) % 360
            windDirection = Double(newWindDirection)
            print("weather updated windSpeed:", "\(windSpeed)", "windDirection:", "\(windDirection)")
        }
        catch {
            print("failed to fetch weather:", error.localizedDescription)
        }
        print("stop tracking")
        stopTracking()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Task {
            await fetchWeather(for: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("weather error:", error.localizedDescription)
    }
}

