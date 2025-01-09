//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var manager = LocationManager.shared
    @State private var fontSize: CGFloat = 128
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(alignment: .center, spacing: 0) {
                    SpeedView()
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(width: geometry.size.width, height: geometry.size.height/3.75)
                    //Spacer()
                    HeadingView()
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(width: geometry.size.width, height: geometry.size.height/3.75)

                    //Spacer()
                    HeelAngleView()
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(width: geometry.size.width, height: geometry.size.height/3.75)

                    PitchAngleView()
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(width: geometry.size.width, height: geometry.size.height/3.75)

                }
                .background(Color.black)
                .foregroundColor(.white)
                .frame(width: geometry.size.width, height: geometry.size.height)
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
                .background(Color.black)
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

#Preview {
    ContentView()
        //.edgesIgnoringSafeArea(.all)

}
