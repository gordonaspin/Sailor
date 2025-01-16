//
//  SpeedView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct SpeedView: View {
    @Environment(LocationManager.self) var locationManager
    @StateObject private var settings = SpeedSetttings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
            VStack() {
                Text(settings.speedUnits)
                    .font(.title)
                    .foregroundColor(settings.color)
                
                Text("\(convertedSpeed, specifier: "%.1f")")
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
                SpeedSettingsView(speedUnits: settings.$speedUnits, items: settings.units, colorIndex: settings.$colorIndex)
            }
    }
    
    private var convertedSpeed: Double {
        print("\(Date().toTimestamp) - \(#function) - \(locationManager.speed)")
        return settings.convertSpeed(speed: locationManager.speed)
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            SpeedView()
                .environment(LocationManager())
                .background(Color.black)
        }
    }
    return Preview()
}
