// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Arten von IV und deren Nutzungsgrenzen, wie sie der Benutzer vorgegeben hat
struct IndividualTransportOptions: Codable {
    enum CodingKeys: String, CodingKey {
        case mode = "Mode"
        case maxDistance = "MaxDistance"
        case maxDuration = "MaxDuration"
        case minDistance = "MinDistance"
        case minDuration = "MinDuration"
        case speed = "Speed"
    }
    
    /// Angabe des IV-Typs. Zugelassen sind hier Werte für Fußweg, Fahrrad, Taxi, selbst gefahrenes Auto, durch andere gefahrenes Auto, Motorrad und LKW.
    /// Der Modus „selbst gefahrenes Auto“ benötigt beim Umstieg in ein anderes Verkehrsmittel einen längerfristigen Parkplatz und ist daher ein
    /// verallgemeinertes Synonym für Park&Ride. Der Modus „durch andere gefahrenes Auto“ benötigt dagegen nur einen Platz zum Aussteigen lassen.
    let mode: IndividualMode
    /// Maximale Distanz in Metern, bis zu der die Nutzung dieses IV-Typs zugelassen ist.
    let maxDistance: Int?
    /// Maximale Zeitdauer, bis zu der die Nutzung dieses IV-Typs zugelassen ist
    let maxDuration: XMLDuration?
    /// Minimale Distanz, ab der die Nutzung dieses IV-Typs zugelassen ist
    let minDistance: Int?
    /// Minimale Zeitdauer, ab der die Nutzung dieses IV-Typs zugelassen ist
    let minDuration: Duration?
    /// Relative Geschwindigkeit in Prozent.
    ///
    /// Wert 100 stellt Standardgeschwindigkeit dar.
    /// Werte kleiner 100 verringern die Geschwindigkeit,
    /// Werte größer 100 vergrößern die Geschwindigkeit anteilig.
    let speed: Double?
}
