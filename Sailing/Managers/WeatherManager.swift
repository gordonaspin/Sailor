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
    var windGustSpeed: Double = 0.0
    var windDirection: Double = 0.0
    var cloudCover: Double = 0.0
    var temperatureF: Double = 0.0
    var temperatureC: Double = 0.0
    var weatherSymbolName: String = ""
    var isAuthorized = false

    override init() {
        super.init()
        print("weather manager initialized")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100
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
        print("start tracking")
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        print("stop tracking")
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
            let newGustSpeed = round(((weather.currentWeather.wind.gust?.value ?? 0.0 > 0 ? weather.currentWeather.wind.gust?.value : 0.0) ?? 0.0) * 10) / 10
            windGustSpeed = newGustSpeed
            
            let newWindDirection: Int = Int(round(weather.currentWeather.wind.direction.value)) % 360
            windDirection = Double(newWindDirection)
            weatherSymbolName = weather.currentWeather.symbolName
            cloudCover = weather.currentWeather.cloudCover
            temperatureF = weather.currentWeather.temperature.converted(to: .fahrenheit).value
            temperatureC = weather.currentWeather.temperature.converted(to: .celsius).value
            print("weather updated windSpeed:", "\(windSpeed)", "windGustSpeed:", "\(windGustSpeed)", "windDirection:", "\(windDirection)")
            print("weather cloudCover:", "\(cloudCover)")
            print("weather symbolname:", "\(weatherSymbolName)")
            print("weather temperature:", "\(temperatureF)°F / \(temperatureC)°C)")
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

