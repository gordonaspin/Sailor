//
//  SpeedView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct SpeedView: View {
    @StateObject private var manager = LocationManager.shared
    @StateObject private var settings = SpeedViewSettings.shared
    @State private var isPickerPresented: Bool = false
    //@State private var speedUnits: String = ""

    var body: some View {
            VStack() {
                Text(settings.speedUnits)
                    .font(.title)
                    .foregroundColor(settings.color)
                    //.onChange(of: speedUnits) {
                    //    settings.setIndex(units: speedUnits)
                    //    }
                
                Text(convertedSpeed)
                    .font(.system(size: settings.fontSize).monospacedDigit())
                    .bold()
                    .foregroundColor(settings.color)
                    .onTapGesture {
                        isPickerPresented = true
                    }
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
            .sheet(isPresented: $isPickerPresented) {
                SpeedUnitsPickerView(speedUnits: settings.$speedUnits, items: settings._units)
            }
            //.onAppear {
            //    speedUnits = settings.units
            //}
    }
    
    private var convertedSpeed: String {
        print("updating speed")
        let convertedValue = settings.convertSpeed(speed: manager.speed)
        return String(format: "%.1f", convertedValue)
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = SpeedViewSettings.shared
        var body: some View {
            SpeedView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
