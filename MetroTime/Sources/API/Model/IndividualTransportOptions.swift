// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Arten von IV und deren Nutzungsgrenzen, wie sie der Benutzer vorgegeben hat
struct IndividualTransportOptions: Codable {
    enum Mode {
        
    }
    
    /// Angabe des IV-Typs. Zugelassen sind hier Werte für Fußweg, Fahrrad, Taxi, selbst gefahrenes Auto, durch andere gefahrenes Auto, Motorrad und LKW.
    /// Der Modus „selbst gefahrenes Auto“ benötigt beim Umstieg in ein anderes Verkehrsmittel einen längerfristigen Parkplatz und ist daher ein
    /// verallgemeinertes Synonym für Park&Ride. Der Modus „durch andere gefahrenes Auto“ benötigt dagegen nur einen Platz zum Aussteigen lassen.
    let mode: Mode
    /// Maximale Distanz in Metern, bis zu der die Nutzung dieses IV-Typs zugelassen ist.
    let maxDistance: Int?
    
    let maxDuration: XMLDuration?
    
    let minDistance: Int?
    
    let minDuration: Duration?
    
    let speed: Double?
    
}
