// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Ergebnisdaten für eine Ortsinformationsanfrage zusammen
struct LocationInformationResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case continueAt = "ContinueAt"
        case errorMessages = "ErrorMessage"
        case locations = "LocationResult"
    }
    
    /// In einem Folgeabruf zu überspringende Ortsobjekte.
    /// Falls gesetzt, zeigt der Dienst an, dass noch weitere Ortsobjekte zu der Anfrage passen, die in der Antwort nicht enthalten sind.
    /// Wird der Abruf wiederholt und dabei der Parameter ContinueAt auf den hier übermittelten Wert gesetzt (vgl. 8.3.7),
    /// liefert der Dienst die folgenden Ortsobjekte.
    let continueAt: Int?
    /// Fehlermeldungen bezogen auf die Gesamtbeantwortung der Anfrage. Siehe die nachstehende Tabelle für mögliche Werte. Vgl. 7.4.2
    let errorMessages: [String]?
    /// Gefundene Ortsobjektergebnisse.
    /// Die Ortsobjekte müssen nach dem Übereinstimmungsgrad mit den Eingabedaten sortiert sein, d.h. das erste ist das am besten passende Objekt. Vgl. 8.4.2
    let locations: [LocationResult]?
    
    init(
        continueAt: Int? = nil,
        errorMessages: [String]? = nil,
        locations: [LocationResult]? = nil
    ) {
        self.continueAt = continueAt
        self.errorMessages = errorMessages
        self.locations = locations
    }
}
