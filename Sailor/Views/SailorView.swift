//
//  ContentView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

struct SailorView: View {

    var body: some View {
        ZStack {
            MapView()
            DefaultLayoutView()
        }
    }
}

#Preview {
    struct Preview: View {
        @StateObject private var settings = HeadingSettings.shared
        var body: some View {
            SailorView()
                .environment(LocationManager())
                .environment(MotionManager())
        }
    }
    return Preview()
}
