// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Daten zu einem einzelnen Abfahrts- oder Ankunftsereignis
struct StopEvent: Codable {
    enum CodingKeys: String, CodingKey {
        case previousCalls = "PreviousCall"
        case thisCall = "ThisCall"
        case onwardCalls = "OnwardCall"
        case service = "Service"
        case operatingDays = "OperatingDays"
        case operatingDaysDescription = "OperatingDaysDescription"
    }
    
    /// Abfahrts-/Ankunftsereignisse an Haltestellen vor der angefragten Haltestelle. Vgl. 10.3.5.
    let previousCalls: [CallAtNearStop]?
    /// Abfahrts-/Ankunftsereignis an der angefragten Haltestelle. Vgl. 10.3.5.
    let thisCall: CallAtNearStop
    /// Abfahrts-/Ankunftsereignis nach der angefragten Haltestelle. Vgl. 10.3.5
    let onwardCalls: [CallAtNearStop]?
    /// Angaben zum Verkehrsmittel, Linie etc. Vgl. 7.6.2
    let service: DatedJourney
    
    // MARK: Operating Days
    /// Verkehrstage für dieses Abfahrts-/Ankunftsereignis. Vgl. 7.4.8.
    let operatingDays: OperatingDays?
    /// Menschenlesbare Beschreibung der Verkehrstage, z. B. „Montag bis Freitag“ oder „Sonn- und Feiertag“.
    let operatingDaysDescription: InternationalText?
}
