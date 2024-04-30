// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Ergebnisdaten für eine Abfahrts- oder Ankunftstafelanfrage zusammen
struct StopEventResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case errorMessage = "ErrorMessage"
        case stopEventResponseContext = "StopEventResponseContext"
        case stopEventResults = "StopEventResult"
    }
    
    // TODO: Use and localize the possible error codes in the PDF
    /// Fehlermeldungen bezogen auf die Gesamtbeantwortung der Anfrage. Siehe die nachstehende Tabelle für mögliche Werte. Vgl. 7.4.2.
    let errorMessage: ErrorMessage?
    /// Container für Daten, die in der Antwort mehrfach auftreten und referenziert werden. Vgl.10.3.2.
    let stopEventResponseContext: StopEventResponseContext?
    /// Container für ein Abfahrts- oder Ankunftsereignis. Vgl. 10.3.3.
    let stopEventResults: [StopEventResult]?
}
