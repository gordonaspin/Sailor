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

    var body: some View {
            VStack() {
                Text(settings.speedUnits)
                    .font(.title)
                    .foregroundColor(settings.color)
                
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
                SpeedUnitsPickerView(speedUnits: settings.$speedUnits, items: settings._units, colorIndex: settings.$colorIndex)
            }
            .onChange(of: settings.colorIndex) {
                print("SpeedView: Color changed \(settings.color)")
            }
    }
    
    private var convertedSpeed: String {
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
