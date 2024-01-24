//
//  UserBPMService.swift
//  TapBPM
//
//  Created by Jonathan Kovatsch on 24.01.2024.
//

import Foundation

class UserBPMService: ObservableObject {
    @Published var heartRate: Double? = nil
    @Published var isHeartRateLoading = false
    private var healthKitManager = HealthKitManager()

    func loadHeartRateData() {
        isHeartRateLoading = true

        healthKitManager.startHeartRateQuery { newHeartRate in
            DispatchQueue.main.async {
                self.heartRate = newHeartRate
                self.isHeartRateLoading = false
            }
        }
    }
}
