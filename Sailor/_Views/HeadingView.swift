//
//  HeadingView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/6/25.
//

import SwiftUI

struct HeadingView: View {
    @StateObject private var manager = LocationManager.shared
    var settings = HeadingViewSettings.shared

    var body: some View {
        VStack() {
            Text("heading")
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
                .swipe( left: {
                            settings.prevColor()
                        },
                        right: {
                            settings.nextColor()
                        })
        }
    }
    
    private var convertedHeading: Int {
        print("update heading")
        switch UIDevice.current.orientation.rawValue {
            case 1: return manager.heading
            case 2: return abs(manager.heading - 90) % 360
            case 3: return (manager.heading + 90) % 360
            case 4: return (manager.heading + 180) % 360
            default: return manager.heading
        }
    }
}

#Preview {
    struct Preview: View {
        private var settings = HeadingViewSettings.shared
        var body: some View {
            HeadingView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()
}
