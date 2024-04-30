// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Klassifizierung der ÖV-Verkehrsmittel (nach TPEG pti_table 01).
enum PTMode: String, Codable {
    case all
    case unknown
    case air
    case bus
    case trolleyBus
    case tram
    case coach
    case rail
    case intercityRail
    case urbanRail
    case metro
    case water
    case cableway
    case funicular
    case taxi
}

/// Struktur zum Filtern nach Verkehrsmitteltypen
struct PTModeFilter: Codable {
    enum CodingKeys: String, CodingKey {
        case exclude = "Exclude"
        case ptModes = "PtMode"
    }
    
    /// Indikator, ob die in der Liste angegebenen Verkehrsmittel ausgeschlossen (Wert `true`) oder als einzige verwendet werden sollen (Wert `false`).
    /// Voreinstellung ist `true`
    let exclude: Bool?
    /// ÖV-Verkehrsmitteltypen
    let ptModes: [PTMode]?
    
    // NOTE: PtSubmodeChoiceGroup not implemented
}
