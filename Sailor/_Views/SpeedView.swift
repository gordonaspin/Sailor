//
//  SpeedView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct SpeedView: View {
    @StateObject private var manager = LocationManager.shared
    var settings = SpeedViewSettings.shared
    
    var body: some View {
            VStack() {
                Text(settings.units)
                    .font(.title)
                    .foregroundColor(settings.color)
                
                Text(convertedSpeed)
                    .font(.system(size: settings.fontSize).monospacedDigit())
                    .bold()
                    .foregroundColor(settings.color)
                    .swipe( up: {
                                settings.nextUnits()
                            },
                            down: {
                                settings.prevUnits()
                            },
                            left: {
                                settings.prevColor()
                            },
                            right: {
                                settings.nextColor()
                            })
            }
    }
    
    private var convertedSpeed: String {
        print("updating speed")
        let conversionFactors = [1.94384, 2.23694, 1.0] // from m/s
        let convertedValue = manager.speed * conversionFactors[settings.unitIndex]
        return String(format: "%.1f", convertedValue)
    }
}

#Preview {
    struct Preview: View {
        private var settings = SpeedViewSettings.shared
        var body: some View {
            SpeedView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
