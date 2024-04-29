// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Resultatstruktur für ein Ortsobjekt
struct LocationResult: Codable {
    enum CodingKeys: String, CodingKey {
        case location = "Location"
        case complete = "Complete"
        case probability = "Probability"
        case modes = "Mode"
    }
    
    /// Eigentliches Ortsobjekt. Vgl. 7.5.10.
    let location: Location
    /// Gibt an, ob das Ortsobjekt schon vollständig ausdifferenziert ist, oder ob es noch verfeinert werden kann
    let complete: Bool
    /// Wahrscheinlichkeit, dass dieses Ortsobjekt dem gesuchten entspricht. Wird mit einem Wert zwischen 0 und 1 angegeben
    let probability: Double?
    /// Auflistung der Verkehrsmittel, die an dem Ortsobjekt verkehren.
    /// Sollte nur bei Haltestellen gefüllt sein und nur dann, wenn es in der Anfrage angefordert wurde. Vgl. 7.3.4
    let modes: [String]?
}
