//
//  ViewSettings.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/8/25.
//

import SwiftUI

protocol ColorProtocol {
    var color: Color { get }
    func nextColor()
    func prevColor()
}

// ViewSettings Base Class
class ViewSettings: ObservableObject {
    let colors = [Color.white, Color.red, Color.green, Color.blue, Color.yellow, Color.cyan, Color.purple, Color.gray]
    var fontSize: CGFloat = 128

}

class SpeedViewSettings: ViewSettings, ColorProtocol {
    static var shared = SpeedViewSettings()
    let _units = ["knots", "mph", "m/s"]
    let _conversionFactors = [1.94384, 2.23694, 1.0] // from m/s
    @AppStorage(wrappedValue: 0, "preference_speedColor") var colorIndex: Int // Accessing the setting from UserDefaults
    @AppStorage(wrappedValue: "knots", "preference_speedUnits") var speedUnits: String // Accessing the setting from UserDefaults

    //var speedUnits: String = ""
    override init() {
        super.init()
        //unitIndex = 0
        print("SpeedViewSetting color: \(colorIndex) \(color)")
        print("SpeedViewSetting units: \(speedUnits)")
        //speedUnits = _units[unitIndex]
    }
    //var speedUnits: String {
    //    return _units[unitIndex]
    //}
    func nextUnits() {
        var unitIndex: Int = _units.firstIndex(of: speedUnits)!
        unitIndex = (unitIndex + 1) % _units.count
        speedUnits = _units[unitIndex]
    }
    func prevUnits() {
        var unitIndex: Int = _units.firstIndex(of: speedUnits)!
        unitIndex = (unitIndex - 1 + _units.count) % _units.count
        speedUnits = _units[unitIndex]
    }
    func setUnits(units: String) {
        speedUnits = units
        /*switch(units) {
            case "kts": unitIndex = 0
            case "mph": unitIndex = 1
            case "m/s": unitIndex = 2
            default:     unitIndex = 0
        }*/
    }
    func convertSpeed(speed: Double) -> Double {
        return speed * _conversionFactors[_units.firstIndex(of: speedUnits)!]
    }
    var color: Color {
        return colors[colorIndex]
    }
    public func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
    }
    public func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
    }
}

class HeadingViewSettings: ViewSettings, ColorProtocol {
    static var shared = HeadingViewSettings()
    @AppStorage(wrappedValue: 3, "preference_headingColor") var colorIndex: Int // Accessing the setting from UserDefaults
    @AppStorage(wrappedValue: false, "preference_trueNorth") var trueNorth: Bool
    
    //var trueNorth: Bool = false
    override init() {
        super.init()
        print("HeadingViewSetting color: \(colorIndex) \(color)")
        print("HeadingViewSetting trueNorth: \(trueNorth)")
    }
    var color: Color {
        return colors[colorIndex]
    }
    public func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
    }
    public func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
    }
}

class HeelAngleViewSettings: ViewSettings, ColorProtocol {
    static var shared = HeelAngleViewSettings()
    @AppStorage(wrappedValue: 1, "preference_heelColor") var colorIndex: Int // Accessing the setting from UserDefaults
    @AppStorage(wrappedValue: 2, "preference_optimumHeelColor") var optimumHeelColorIndex: Int // Accessing the setting from UserDefaults
    @AppStorage(wrappedValue: "The boat is too flat", "preference_underHeelAlarm") var underHeelAlarm: String // Accessing the setting from UserDefaults
    @AppStorage(wrappedValue: "Too much heel", "preferences_overHeelAlarm") var overHeelAlarm: String // Accessing the setting from UserDefaults
    @AppStorage(wrappedValue: 15, "preference_optimumHeelAngle") var optimumHeelAngle: Int // Accessing the setting from UserDefaults

    //var colorIndex: Int = 1
    var currentColorIndex: Int = 1
    
    override init() {
        super.init()
        currentColorIndex = colorIndex
        print("HeelAngleViewSetting colorIndex: \(colorIndex) \(color)")
        print("HeelAngleViewSetting optimumHeelColorIndex: \(optimumHeelColorIndex)")
        print("HeelAngleViewSetting underHeelAlarm: \(underHeelAlarm)")
        print("HeelAngleViewSetting overHeelAlarm: \(overHeelAlarm)")
        print("HeelAngleViewSetting optimumHeelAngle: \(optimumHeelAngle)")

    }
    func setOptimumHeelColor() {
        currentColorIndex = optimumHeelColorIndex
    }
    func resetColor() {
        if currentColorIndex != colorIndex {
            currentColorIndex = colorIndex
        }
    }
    func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
        currentColorIndex = colorIndex
    }
    func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
        currentColorIndex = colorIndex
    }
    var titleColor: Color {
        return colors[colorIndex]
    }
    var color: Color {
        return colors[currentColorIndex]
    }
    //var optimumHeelAngle: Int {
    //    return optimumHeelAngle
    //}
}

class PitchAngleViewSettings: ViewSettings, ColorProtocol {
    static var shared = PitchAngleViewSettings()
    @AppStorage(wrappedValue: 4, "preference_pitchColor") var colorIndex: Int // Accessing the setting from UserDefaults

    override init() {
        super.init()
        print("PitchAngleViewSetting color: \(colorIndex) \(color)")
    }
    var color: Color {
        return colors[colorIndex]
    }
    public func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
    }
    public func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
    }
}

