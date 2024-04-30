// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Struktur zum Filtern nach Verkehrsunternehmen
struct OperatorFilter: Codable {
    enum CodingKeys: String, CodingKey {
        case exclude = "Exclude"
        case operatorRef = "OperatorRef"
    }
    
    /// Indikator, ob die in der Liste angegebenen Verkehrsunternehmen ausgeschlossen (Wert `true`) oder als einzige verwendet werden sollen (Wert `false`).
    /// Voreinstellung ist `true`.
    let exclude: Bool?
    /// Referenz auf Verkehrsunternehmen. Vgl. 7.4.1.
    let operatorRef: [String]?
    
    init(exclude: Bool? = nil, operatorRef: [String]? = nil) {
        self.exclude = exclude
        self.operatorRef = operatorRef
    }
}
