// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Ergebnisdaten für ein einzelnes Abfahrts- oder Ankunftsereignis zusammen
struct StopEventResult: Codable {
    enum CodingKeys: String, CodingKey {
        case resultID = "ResultId"
        case errorMessages = "ErrorMessage"
        case stopEvent = "StopEvent"
    }
    
    /// ID des Resultats für spätere Referenzierung bzw. für Debug-Zwecke
    let resultID: String
    // TODO: Decode and localize possible errors
    /// Fehlermeldungen bezogen auf dieses Abfahrts-/Ankunftsereignis. Siehe die nachstehende Tabelle für mögliche Werte. Vgl. auch 7.4.2
    let errorMessages: [ErrorMessage]?
    /// Daten zu einem Abfahrts- oder Ankunftsereignis. Vgl. 10.3.4.
    let stopEvent: StopEvent
}
