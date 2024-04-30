// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Objekt-ID innerhalb eines proprietären (privaten) Schlüsselsystems (Fremdschlüssel).
struct PrivateCode: Codable {
    enum CodingKeys: String, CodingKey {
        case system = "System"
        case value = "Value"
    }
    
    /// Bezeichnung des Schlüsselsystems
    let system: String
    /// Code/Objekt-ID
    let value: String
}
