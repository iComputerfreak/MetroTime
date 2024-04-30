// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Referenz auf eine Situationsbeschreibung
struct SituationFullRef: Codable {
    enum CodingKeys: String, CodingKey {
        case versionCountryRef = "VersionCountryRef"
        case participantRef = "ParticipantRef"
        case situationNumber = "SituationNumber"
        case updateParticipantRef = "UpdateParticipantRef"
        case version = "Version"
    }
    
    /// Referenziert das Land, um ggf. die ParticipantRef eindeutig zu machen
    let versionCountryRef: String?
    /// Eindeutige ID des Schnittstellenpartners (vgl. 5.12). Stellt Namensraum für die ID der Situation bereit
    let participantRef: String?
    /// Eindeutige ID der Situation
    let situationNumber: String?
    /// Eindeutige ID des Schnittstellenpartners (vgl. 5.12). Stellt Namensraum für die ID der Situation bereit
    let updateParticipantRef: String?
    /// Versionsnummer des Updates zur Situation. Kann bei der Erstmeldung entfallen.
    let version: String
}
