// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Abfahrt oder Ankunft an einer Haltestelle in der Umgebung
struct CallAtNearStop: Codable {
    enum CodingKeys: String, CodingKey {
        case callAtStop = "CallAtStop"
        case walkDistance = "WalkDistance"
        case walkDuration = "WalkDuration"
    }
    
    /// Abfahrt oder Ankunft an einem Haltepunkt. Vgl. 7.6.6
    let callAtStop: CallAtStop
    /// Distanz des Haltepunkts vom angefragten Ort in Metern. Der angefragte Ort kann z. B. eine Adresse sein
    let walkDistance: Int?
    /// Zeitliche Distanz des Haltepunkts vom angefragten Ort.
    ///
    /// Der angefragte Ort kann z. B. eine Adresse sein.
    /// Der Zeitbedarf ergibt sich durch die IV-Einstellungen in der Anfrage: es wird also z. B. berücksichtigt, ob ein Fahrrad benutzt werden kann,
    /// um vom angefragten Ort zum Abfahrtshaltepunkt zu gelangen.
    let walkDuration: XMLDuration?
}
