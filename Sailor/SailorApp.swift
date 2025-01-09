//
//  SailorApp.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/5/25.
//

import SwiftUI

@main
struct SailorApp: App {
    init() {
        print("SaliorApp init")
        // Force dark mode for the app
        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
