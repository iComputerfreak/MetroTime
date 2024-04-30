// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Struktur für die Definition von Attributen/Hinweisen
struct GeneralAttribute: Codable {
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case code = "Code"
        case mandatory = "Mandatory"
        case importance = "Importance"
        case infoURL = "InfoURL"
    }
    
    /// Attributtext für die Fahrgastinformation
    let text: InternationalText
    /// Interner Attribute-Code. Kann verwendet werden, um mehrfaches Auftreten desselben Attributs zu erkennen
    let code: String
    
    // MARK: All Facilities
    // NOTE: siri:AllFacilitiesGroup attributes are not implemented.
    
    /// Legt fest, ob das Attribut in jedem Fall angezeigt werden muss. Voreinstellung ist `false`
    let mandatory: Bool?
    /// Wichtigkeit für die Priorisierung von Attributen gegeneinander
    let importance: Double?
    /// URL zu weiteren Informationen über dieses Attribut. Falls vorhanden, soll der gesamte Text als Link zu dieser URL gekennzeichnet werden
    let infoURL: URL?
}
