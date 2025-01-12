//
//  HeadingView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct HeadingView: View {
    @StateObject private var manager = LocationManager.shared
    @StateObject private var settings = HeadingViewSettings.shared
    @State private var isPickerPresented: Bool = false

    var body: some View {
        VStack() {
            Text("\(settings.trueNorth ? "true" : "magnetic") heading")
                .font(.title)
                .foregroundColor(settings.color)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) {
                    _ in
                    let orientation = UIDevice.current.orientation.rawValue
                    let orientationName = getOrientation(orientation: orientation)
                    if UIDevice.current.orientation.isValidInterfaceOrientation
                    {
                        print("HeadingView: \(orientation) \(orientationName)")
                    }
                    else {
                        print("HeadingView: invalid orientation \(orientation) \(orientationName)")
                    }
                }
            
            Text("\(convertedHeading, specifier: "%03d")º")
                .font(.system(size: settings.fontSize).monospacedDigit())
                .bold()
                .foregroundColor(settings.color)
                .onTapGesture {
                    isPickerPresented = true
                }
                .swipe( left: {
                            settings.prevColor()
                        },
                        right: {
                            settings.nextColor()
                        })
        }
        .sheet(isPresented: $isPickerPresented) {
            TrueOrMagneticHeadingPickerView(trueNorth: $settings.trueNorth)
        }
        //.onChange(of: trueNorth) {
        //    settings.trueNorth = trueNorth
        //}
        //.onAppear() {
        //    trueNorth = settings.trueNorth
        //}
    }
    
    private var convertedHeading: Int {
        //print("update \(trueNorth ? "true" : "magnetic") heading")
        let heading: Int = settings.trueNorth ? manager.trueHeading : manager.magneticHeading
        switch UIDevice.current.orientation.rawValue {
            case 1: return heading
            case 2: return abs(heading - 90) % 360
            case 3: return (heading + 90) % 360
            case 4: return (heading + 180) % 360
            default: return heading
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingViewSettings.shared
        var body: some View {
            HeadingView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
