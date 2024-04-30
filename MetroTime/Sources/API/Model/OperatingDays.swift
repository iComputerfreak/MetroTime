// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Struktur für die Definition von Verkehrstagen mittels Bit-Kette
struct OperatingDays: Codable {
    enum CodingKeys: String, CodingKey {
        case from = "From"
        case to = "To"
        case pattern = "Pattern"
    }
    
    /// Startdatum des Zeitraums
    let from: Date
    /// Enddatum des Zeitraums
    let to: Date
    /// Bitmuster für die Verkehrstage im Zeitraum von Startdatum (From) bis Enddatum (To).
    /// Die Länge des Bitmusters in Pattern entspricht der Anzahl der Tage von From bis To.
    /// Eine „1“ bedeutet, dass das in Frage kommende Ereignis an dem Tag stattfindet, der der Position in der Bitkette entspricht
    let pattern: String
}
