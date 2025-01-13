//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var manager = LocationManager.shared
    
    var body: some View {
        ZStack {
            Map(position: $manager.userPosition, bounds: manager.mapBounds) {
            }
            .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                if geometry.size.height > geometry.size.width {
                    VStack(alignment: .center, spacing: 0) {
                        SpeedView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        HeadingView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        HeelAngleView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        PitchAngleView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Color.black.opacity(0.2))
                }
                else {
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            SpeedView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            HeadingView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        HStack(alignment: .center, spacing: 0){
                            HeelAngleView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            PitchAngleView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.2))
                }
            }
            .onAppear() {
                print("SaliorApp ContentView onAppear")
                UIApplication.shared.isIdleTimerDisabled = true
                manager.requestAuthorization()
            }
            .onDisappear() {
                UIApplication.shared.isIdleTimerDisabled = false
                manager.stopTracking()
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject var manager = LocationManager.shared
        var body: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
    return Preview()

}
