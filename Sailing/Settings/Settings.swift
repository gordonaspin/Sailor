//
//  Settings.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/8/25.
//

import SwiftUI

protocol ColorProtocol {
    var color: Color { get }
}

// Settings Base Class
class Settings: ObservableObject {
    let colors: [(name: String, color: Color)] = [
        ("White", Color.white),     // 0
        ("Red", Color.red),         // 1
        ("Green", Color.green),     // 2
        ("Blue", Color.blue),       // 3
        ("Yellow", Color.yellow),   // 4
        ("Cyan", Color.cyan),       // 5
        ("Purple", Color.purple),   // 6
        ("Gray", Color.gray),       // 7
        ("Black", Color.black)      // 9
    ]
}

class BoatSpeedSetttings: Settings, ColorProtocol {
    static var shared = BoatSpeedSetttings()
    let longUnits = ["Knots", "Miles Per Hour", "Meters Per Second"]
    let units = ["KTS", "MPH", "M/S"]
    let conversionFactors = [1.94384, 2.23694, 1.0] // from m/s
    @AppStorage(wrappedValue: 0, "preference_speedColor") var colorIndex: Int
    @AppStorage(wrappedValue: "KTS", "preference_speedUnits") var speedUnits: String

    override init() {
        super.init()
        print("SpeedViewSetting color:", "\(colorIndex)", "\(color)")
        print("SpeedViewSetting units:", "\(speedUnits)")
    }
    func convertSpeed(speed: Double) -> Double {
        if let i = units.firstIndex(of: speedUnits) {
            return speed * conversionFactors[i]
        }
        else {
            return 0.0
        }
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class BoatHeadingSettings: Settings, ColorProtocol {
    static var shared = BoatHeadingSettings()
    @AppStorage(wrappedValue: 5, "preference_headingColor") var colorIndex: Int
    @AppStorage(wrappedValue: false, "preference_trueNorth") var trueNorth: Bool

    override init() {
        super.init()
        print("HeadingViewSetting color:", "\(colorIndex)", "\(color)")
        print("HeadingViewSetting trueNorth:", "\(trueNorth)")
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class HeelAngleSettings: Settings, ColorProtocol {
    let optimumHeelAngles = [0, 25]
    let optimumHeelAngleTolerances = [1, 5]

    static var shared = HeelAngleSettings()
    @AppStorage(wrappedValue: 1, "preference_heelColor") var colorIndex: Int
    @AppStorage(wrappedValue: 2, "preference_optimumHeelColor") var optimumHeelColorIndex: Int
    @AppStorage(wrappedValue: false, "preference_speakHeelAlarms") var speakHeelAlarms: Bool
    @AppStorage(wrappedValue: "The boat is too flat", "preference_underHeelAlarm") var underHeelAlarm: String
    @AppStorage(wrappedValue: "Too much heel", "preferences_overHeelAlarm") var overHeelAlarm: String
    @AppStorage(wrappedValue: 15, "preference_optimumHeelAngle") var optimumHeelAngle: Int
    @AppStorage(wrappedValue: 2, "preference_optimumHeelAngleTolerance") var optimumHeelAngleTolerance: Int
    @AppStorage(wrappedValue: true, "preference_heelAngleWindwardLeeward") var heelAngleWindwardLeeward: Bool

    var currentColorIndex: Int = 1
    
    override init() {
        super.init()
        currentColorIndex = colorIndex
        print("HeelAngleViewSetting colorIndex:", "\(colorIndex)", "\(color)")
        print("HeelAngleViewSetting optimumHeelColorIndex:", "\(optimumHeelColorIndex)")
        print("HeelAngleViewSetting speakHeelAlarms:", "\(speakHeelAlarms)")
        print("HeelAngleViewSetting underHeelAlarm:", "\(underHeelAlarm)")
        print("HeelAngleViewSetting overHeelAlarm:", "\(overHeelAlarm)")
        print("HeelAngleViewSetting optimumHeelAngle:", "\(optimumHeelAngle)")
        print("HeelAngleViewSetting optimumHeelAngleTolerance:", "\(optimumHeelAngleTolerance)")
        print("HeelAngleViewSetting heelAngleWindwardLeeward:", "\(heelAngleWindwardLeeward)")
    }
    func setOptimumHeelColor() {
        currentColorIndex = optimumHeelColorIndex
    }
    func resetColor() {
        if currentColorIndex != colorIndex {
            currentColorIndex = colorIndex
        }
    }
    var titleColor: Color {
        return colors[colorIndex].color
    }
    var color: Color {
        return colors[currentColorIndex].color
    }
}

class PitchAngleSettings: Settings, ColorProtocol {
    static var shared = PitchAngleSettings()
    @AppStorage(wrappedValue: 4, "preference_pitchColor") var colorIndex: Int

    override init() {
        super.init()
        print("PitchAngleViewSetting color:", "\(colorIndex)", "\(color)")
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class WindDirectionSettings: Settings, ColorProtocol {
    static var shared = WindDirectionSettings()
    @AppStorage(wrappedValue: 7, "preference_windDirectionColor") var colorIndex: Int

    override init() {
        super.init()
        print("WindDirectionViewSetting color:", "\(colorIndex)", "\(color)")
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class WindSpeedSetttings: Settings, ColorProtocol {
    static var shared = WindSpeedSetttings()
    let longUnits = ["Knots", "Miles per hour", "Kilometers per hour"]
    let units = ["KTS", "MPH", "KM/H"]
    let conversionFactors = [0.539957, 0.621371, 1.0] // from km/h
    @AppStorage(wrappedValue: 7, "preference_windSpeedColor") var colorIndex: Int
    @AppStorage(wrappedValue: "KTS", "preference_windSpeedUnits") var speedUnits: String
    @AppStorage(wrappedValue: false, "preference_temperatureCelcius") var temperatureCelcius: Bool

    override init() {
        super.init()
        print("WindSpeedSetttings color:", "\(colorIndex)", "\(color)")
        print("WindSpeedSetttings units:", "\(speedUnits)")
        print("WindSpeedSetttings temperatureCelcius:", "\(temperatureCelcius)")
    }
    func setUnits(units: String) {
        speedUnits = units
    }
    func convertSpeed(speed: Double) -> Double {
        if let i = units.firstIndex(of: speedUnits) {
            return speed * conversionFactors[i]
        }
        else {
            return 0.0
        }
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class RaceTimerSettings: Settings {
    static var shared = RaceTimerSettings()
    let raceTimerValues = [1*60, 15*60]
    @AppStorage(wrappedValue: 300, "preference_raceTimer") var raceTimer: Int
    @AppStorage(wrappedValue: true, "preference_speakTimerAlerts") var speakTimerAlerts: Bool
    @AppStorage(wrappedValue: true, "preference_audibleTimerAlerts") var audibleTimerAlerts: Bool

    override init() {
        super.init()
        print("RaceTimerSetttings raceTimer:", "\(raceTimer)")
    }
}

class ApparentWindAngleSettings: Settings, ColorProtocol {
    static var shared = ApparentWindAngleSettings()
    @AppStorage(wrappedValue: 7, "preference_ApparentWindAngleColor") var colorIndex: Int

    override init() {
        super.init()
        print("ApparentWindAngleViewSetting color:", "\(colorIndex)", "\(color)")
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class ApparentWindSpeedSetttings: Settings, ColorProtocol {
    static var shared = ApparentWindSpeedSetttings()
    let longUnits = ["Knots", "Miles per hour", "Kilometers per hour"]
    let units = ["KTS", "MPH", "KM/H"]
    let conversionFactors = [0.539957, 0.621371, 1.0] // from km/h
    @AppStorage(wrappedValue: 7, "preference_apparentWindSpeedColor") var colorIndex: Int
    @AppStorage(wrappedValue: "KTS", "preference_apparentWindSpeedUnits") var speedUnits: String

    override init() {
        super.init()
        print("ApparentWindSpeedSetting color:", "\(colorIndex)", "\(color)")
        print("ApparentWindSpeedSetting units:", "\(speedUnits)")
    }
    func setUnits(units: String) {
        speedUnits = units
    }
    func convertSpeed(speed: Double) -> Double {
        if let i = units.firstIndex(of: speedUnits) {
            return speed * conversionFactors[i]
        }
        else {
            return 0.0
        }
    }
    var color: Color {
        return colors[colorIndex].color
    }
}

class InstrumentSettings: Settings {
    @AppStorage(wrappedValue: "0T1T2T3T4T5T6T7T", "preferences_Instruments") var instrumentStr: String
    
    override init() {
        super.init()
        print("Instruments:", "\(instrumentStr)")
    }
}
