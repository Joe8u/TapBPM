//
//  ContentView.swift
//  TapBPM Watch App
//
//  Created by Jonathan Kovatsch on 24.01.2024.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject private var userTapBPMService = UserTapBPMService()
    @StateObject private var userBPMService = UserBPMService()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Anzeige der UserBPM und TapBPM
                VStack {
                    Text(userBPMService.heartRate != nil ? "UserBPM: \(userBPMService.heartRate!, specifier: "%.0f")" : "Tap to start")
                        .font(.system(size: geometry.size.width * 0.1))
                        .padding()

                    Text("TapBPM: \(userTapBPMService.currentTapBPM, specifier: "%.0f")")
                        .font(.system(size: geometry.size.width * 0.1))
                        .padding()
                }
                .frame(height: geometry.size.height * 0.9 / 3)

                Spacer()

                // Button zum Erfassen der Tap-Ereignisse und Laden der Herzfrequenzdaten
                Button(action: {
                    userBPMService.loadHeartRateData()
                    userTapBPMService.registerTap()
                }) {
                    Text("Tap")
                        .font(.system(size: geometry.size.width * 0.25))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 2.5)
                        .background(Color.blue)
                        .cornerRadius(geometry.size.width * 0.6)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



