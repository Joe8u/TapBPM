//
//  TapBPMApp.swift
//  TapBPM Watch App
//
//  Created by Jonathan Kovatsch on 24.01.2024.
//


import SwiftUI
import HealthKit

@main
struct TapBPM_Watch_AppApp: App {
    private var healthKitManager = HealthKitManager()

    init() {
        // Anfordern der Berechtigung, wenn die App initialisiert wird
        healthKitManager.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
