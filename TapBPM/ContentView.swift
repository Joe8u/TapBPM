//
//  ContentView.swift
//  TapBPM
//
//  Created by Jonathan Kovatsch on 24.01.2024.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject private var userTapBPMService = UserTapBPMService()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Vertikale Stapelansicht für TapBPM-Anzeige
                VStack {
                    Text("TapBPM:")
                        .font(.system(size: geometry.size.height * 0.06))
                        .foregroundColor(.white)
                        .padding([.top, .leading, .trailing])

                    Text("\(userTapBPMService.currentTapBPM, specifier: "%.0f")")
                        .font(.system(size: geometry.size.height * 0.15)) // Größere Schrift für die Zahl
                        .foregroundColor(.white)
                }
                .frame(height: geometry.size.height * 0.5) // Die obere Hälfte des Bildschirms einnehmen

                // Button zum Erfassen der Tap-Ereignisse
                Button(action: {
                    // Erfassen des aktuellen Zeitpunkts als Tap-Ereignis
                    userTapBPMService.registerTap()
                }) {
                    Text("Tap")
                        .font(.largeTitle) // Größere Schriftart für den Button
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Button nimmt verfügbaren Platz ein
                        .background(Color.blue)
                }
                .frame(height: geometry.size.height * 0.5) // Die untere Hälfte des Bildschirms einnehmen
            }
            .background(Color.black) // Schwarzer Hintergrund
        }
        .edgesIgnoringSafeArea(.all) // Ignoriert den Safe Area, um den ganzen Bildschirm zu füllen
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


