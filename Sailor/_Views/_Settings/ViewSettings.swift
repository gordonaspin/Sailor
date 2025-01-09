//
//  ViewSettings.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/8/25.
//

import SwiftUI

// ViewSettings Base Class
class ViewSettings {
    let colors = [Color.white, Color.red, Color.green, Color.blue, Color.yellow, Color.cyan, Color.purple, Color.gray]
    fileprivate var colorIndex: Int = 0
    var fontSize: CGFloat = 128
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

class SpeedViewSettings: ViewSettings, ObservableObject {
    static var shared = SpeedViewSettings()
    var unitIndex: Int = 0
    let _units = ["kts", "mph", "m/s"]
    let _conversionFactors = [1.94384, 2.23694, 1.0] // from m/s


    override init() {
        super.init()
        colorIndex = 0
    }
    var units: String {
        return _units[unitIndex]
    }
    func nextUnits() {
        unitIndex = (unitIndex + 1) % _units.count
    }
    func prevUnits() {
        unitIndex = (unitIndex - 1 + _units.count) % _units.count
    }
    func setIndex(units: String) {
        switch(units) {
            case "kts": unitIndex = 0
            case "mph": unitIndex = 1
            case "m/s": unitIndex = 2
            default:     unitIndex = 0
        }
    }
    func convertSpeed(speed: Double) -> Double {
        return speed * _conversionFactors[unitIndex]
    }
}

class HeadingViewSettings: ViewSettings {
    static var shared = HeadingViewSettings()
    override init() {
        super.init()
        colorIndex = 3
    }
}

class HeelAngleViewSettings: ViewSettings {
    static var shared = HeelAngleViewSettings()
    //var colorIndex: Int = 1
    var chosenColorIndex: Int = 1
    var optimumTiltColorIndex: Int = 2
    let minimumHeelAngle: Int = 10
    let maximumHeelAngle: Int = 20
    override init() {
        super.init()
        colorIndex = 1
    }
    func setOptimumTiltColor() {
        colorIndex = optimumTiltColorIndex
    }
    func setChosenColor() {
        colorIndex = chosenColorIndex
    }
    override func nextColor() {
        super.nextColor()
        chosenColorIndex = colorIndex
    }
    override func prevColor() {
        super.prevColor()
        chosenColorIndex = colorIndex
    }
}

class PitchAngleViewSettings: ViewSettings {
    static var shared = PitchAngleViewSettings()
    override init() {
        super.init()
        colorIndex = 4
    }
}

