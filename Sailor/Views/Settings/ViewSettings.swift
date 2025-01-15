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
    //let colors = [Color.white, Color.red, Color.green, Color.blue, Color.yellow, Color.cyan, Color.purple, Color.gray]
    let colors: [(name: String, color: Color)] = [
        ("White", Color.white),
        ("Red", Color.red),
        ("Green", Color.green),
        ("Blue", Color.blue),
        ("Yellow", Color.yellow),
        ("Cyan", Color.cyan),
        ("Purple", Color.purple),
        ("Grey", Color.gray)
    ]
    var fontSize: CGFloat = 128

}

class SpeedViewSettings: ViewSettings, ColorProtocol {
    static var shared = SpeedViewSettings()
    let units = ["knots", "mph", "m/s"]
    let conversionFactors = [1.94384, 2.23694, 1.0] // from m/s
    @AppStorage(wrappedValue: 0, "preference_speedColor") var colorIndex: Int
    @AppStorage(wrappedValue: "knots", "preference_speedUnits") var speedUnits: String

    override init() {
        super.init()
        print("SpeedViewSetting color: \(colorIndex) \(color)")
        print("SpeedViewSetting units: \(speedUnits)")
    }
    func nextUnits() {
        var unitIndex: Int = units.firstIndex(of: speedUnits)!
        unitIndex = (unitIndex + 1) % units.count
        speedUnits = units[unitIndex]
    }
    func prevUnits() {
        var unitIndex: Int = units.firstIndex(of: speedUnits)!
        unitIndex = (unitIndex - 1 + units.count) % units.count
        speedUnits = units[unitIndex]
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
    public func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
    }
    public func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
    }
}

class HeadingViewSettings: ViewSettings, ColorProtocol {
    static var shared = HeadingViewSettings()
    @AppStorage(wrappedValue: 3, "preference_headingColor") var colorIndex: Int
    @AppStorage(wrappedValue: false, "preference_trueNorth") var trueNorth: Bool
    
    override init() {
        super.init()
        print("HeadingViewSetting color: \(colorIndex) \(color)")
        print("HeadingViewSetting trueNorth: \(trueNorth)")
    }
    var color: Color {
        return colors[colorIndex].color
    }
    public func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
    }
    public func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
    }
}

class HeelAngleViewSettings: ViewSettings, ColorProtocol {
    let optimumHeelAngles = [10, 15, 20]
    
    static var shared = HeelAngleViewSettings()
    @AppStorage(wrappedValue: 1, "preference_heelColor") var colorIndex: Int
    @AppStorage(wrappedValue: 2, "preference_optimumHeelColor") var optimumHeelColorIndex: Int
    @AppStorage(wrappedValue: "The boat is too flat", "preference_underHeelAlarm") var underHeelAlarm: String
    @AppStorage(wrappedValue: "Too much heel", "preferences_overHeelAlarm") var overHeelAlarm: String
    @AppStorage(wrappedValue: 15, "preference_optimumHeelAngle") var optimumHeelAngle: Int
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
        return colors[colorIndex].color
    }
    var color: Color {
        return colors[currentColorIndex].color
    }
}

class PitchAngleViewSettings: ViewSettings, ColorProtocol {
    static var shared = PitchAngleViewSettings()
    @AppStorage(wrappedValue: 4, "preference_pitchColor") var colorIndex: Int

    override init() {
        super.init()
        print("PitchAngleViewSetting color: \(colorIndex) \(color)")
    }
    var color: Color {
        return colors[colorIndex].color
    }
    public func nextColor() {
        colorIndex = (colorIndex + 1) % colors.count
    }
    public func prevColor() {
        colorIndex = (colorIndex - 1 + colors.count) % colors.count
    }
}

