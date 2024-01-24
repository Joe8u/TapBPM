//
//  UserTapBPMService.swift
//  TapBPM
//
//  Created by Jonathan Kovatsch on 24.01.2024.
//

import Foundation
import Combine

class UserTapBPMService: ObservableObject {
    private var tapTimes: [Date] = []
    private let maxTapTimesStored = 3

    @Published var currentTapBPM: Double = 0

    // Berechnet die aktuelle TapBPM basierend auf den gespeicherten Tap-Zeiten
    private func calculateCurrentTapBPM() {
        guard tapTimes.count >= 2 else { return }
        let intervals = tapTimes.enumerated().compactMap { index, time in
            (index > 0) ? time.timeIntervalSince(tapTimes[index - 1]) : nil
        }
        let averageInterval = intervals.reduce(0, +) / Double(intervals.count)
        currentTapBPM = averageInterval > 0 ? 60 / averageInterval : 0
    }

    // Funktion zum Registrieren eines Taps
    public func registerTap() {
        let now = Date()
        tapTimes.append(now)

        // Beschränkt die Anzahl der gespeicherten Tap-Zeiten
        if tapTimes.count > maxTapTimesStored {
            tapTimes.removeFirst(tapTimes.count - maxTapTimesStored)
        }

        calculateCurrentTapBPM()
    }
}


