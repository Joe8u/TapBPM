//
//  HealthKitManager.swift
//  TapBPM
//
//  Created by Jonathan Kovatsch on 24.01.2024.
//
import Foundation
import HealthKit

class HealthKitManager {
    private var healthStore = HKHealthStore()
    private var heartRateQuery: HKQuery?
    

    // Funktion zum Starten der Herzfrequenzmessung
    func startHeartRateQuery(heartRateUpdated: @escaping (Double) -> Void) {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            return // Der Herzfrequenztyp ist nicht verfügbar
        }

        let heartRateUnit = HKUnit(from: "count/min")

        // Abfrage erstellen
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: nil, limit: HKObjectQueryNoLimit) { _, samples, _, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Aktuelle Herzfrequenz aus den Samples extrahieren
            guard let heartRateSamples = samples as? [HKQuantitySample] else { return }
            guard let sample = heartRateSamples.last else { return }
            let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
            
            // Rückruf mit der neuen Herzfrequenz
            heartRateUpdated(heartRate)
        }
        
        // Konfiguration für die Abfrage, um Aktualisierungen in Echtzeit zu erhalten
        query.updateHandler = { _, samples, _, _, error in
            if let error = error {
                print("Update Error: \(error.localizedDescription)")
                return
            }
            print("Received heart rate samples: \(String(describing: samples))")
            
            // Aktuelle Herzfrequenz aus den Samples extrahieren
            guard let heartRateSamples = samples as? [HKQuantitySample] else { return }
            guard let sample = heartRateSamples.last else { return }
            let heartRate = sample.quantity.doubleValue(for: heartRateUnit)
            
            // Rückruf mit der neuen Herzfrequenz
            heartRateUpdated(heartRate)
        }
        
        // Abfrage starten
        self.heartRateQuery = query
        healthStore.execute(query)
    }
    
    // Diese Funktion könnte verwendet werden, um den Stream zu stoppen
    func stopHeartRateQuery() {
        if let query = heartRateQuery {
            healthStore.stop(query)
        }
    }
    
    func requestAuthorization() {
            // Überprüfen, ob HealthKit auf diesem Gerät verfügbar ist
            guard HKHealthStore.isHealthDataAvailable() else {
                return
            }

            // Definieren der Datentypen, auf die zugegriffen werden soll
            guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
                return
            }

            // Anfordern der Berechtigung
            healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { success, error in
                if let error = error {
                    print("Fehler beim Anfordern der HealthKit-Berechtigung: \(error.localizedDescription)")
                    return
                }

                if success {
                    // Berechtigung erfolgreich erhalten, weitere Aktionen können hier ausgeführt werden
                    print("HealthKit Berechtigung erhalten")
                } else {
                    // Der Benutzer hat die Berechtigung verweigert
                    print("HealthKit Berechtigung verweigert")
                }
            }
        }
    
    
}
