// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Struktur zur Meldung von Fehlerzuständen
struct ErrorMessage: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case text = "Text"
    }
    
    /// Code des Fehlerzustands
    let code: String
    /// Beschreibung des Fehlerzustands
    let text: InternationalText?
}
