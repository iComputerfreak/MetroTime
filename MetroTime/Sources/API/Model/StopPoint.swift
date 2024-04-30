// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modellierung eines Haltepunkts
struct StopPoint: Codable {
    enum CodingKeys: String, CodingKey {
        case stopPointRef = "StopPointRef"
        case stopPointName = "StopPointName"
        case nameSuffix = "NameSuffix"
        case plannedBay = "PlannedBay"
        case estimatedBay = "EstimatedBay"
        case privateCodes = "PrivateCodes"
        case parentRef = "ParentRef"
        case localityRef = "LocalityRef"
        case wheelchairAccessible = "WheelchairAccessible"
        case lighting = "Lighting"
        case covered = "Covered"
    }
    
    // MARK: StopPoint
    /// Referenz auf einen Code für einen Haltepunkt. Vgl. 7.5.1.
    let stopPointRef: String
    /// Name des Haltepunkts für Fahrgastinformation
    let stopPointName: InternationalText
    /// Namenszusatz, der bei Platzmangel evtl. auch weggelassen werden kann, z. B.: "gegenüber vom Haupteingang")
    let nameSuffix: InternationalText?
    /// Name des Steigs/Haltepunkts, wo in das Fahrzeug ein- oder ausgestiegen werden muss (bei Verwendung in Zusammenhang mit einer konkreten
    /// Verbindungsauskunft, wenn in `stopPointName` ein allgemeiner Name angegeben ist, ähnlich Haltestellenname).
    ///
    /// Nach Planungsstand.
    let plannedBay: InternationalText?
    /// Name des Steigs/Haltepunkts, wo in das Fahrzeug ein- oder ausgestiegen werden muss (bei Verwendung in Zusammenhang mit einer konkreten
    /// Verbindungsauskunft, wenn in StopPointName ein allgemeiner Name angegeben ist, ähnlich Haltestellenname).
    ///
    /// Nach letztem Prognosestand.
    let estimatedBay: InternationalText?
    
    /// Privater Code für diesen Haltepunkt in einem anderen Schlüsselsystem. Vgl. 7.4.3.
    let privateCodes: [PrivateCode]?
    /// Referenz auf die Haltestelle, zu der dieser Haltepunkt gehört. Vgl. 7.5.1
    let parentRef: String?
    /// Referenz auf die Ortschaft, zu der dieser Haltepunkt gehört. Vgl. 7.5.1.
    let localityRef: String?
    
    // MARK: StopAttributes
    /// Rollstuhltauglichkeit dieses Haltepunkts
    let wheelchairAccessible: Bool?
    /// Angabe zur Beleuchtung dieses Haltepunkts
    let lighting: Bool?
    /// Angabe, ob dieser Haltepunkt Witterungsschutz bietet (vor Regen, Schnee, Sturm etc.).
    let covered: Bool?
}
