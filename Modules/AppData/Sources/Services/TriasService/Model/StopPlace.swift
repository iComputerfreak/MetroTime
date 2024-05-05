// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modellierung einer Haltestelle.
struct StopPlace: Codable {
    enum CodingKeys: String, CodingKey {
        case stopPlaceRef = "StopPlaceRef"
        case stopPlaceName = "StopPlaceName"
        case nameSuffix = "NameSuffix"
        case privateCodes = "PrivateCodes"
        case localityRef = "LocalityRef"
        case wheelchairAccessible = "WheelchairAccessible"
        case lighting = "Lighting"
        case covered = "Covered"
    }
    
    // MARK: StopPlace
    /// Referenz auf einen Code für eine Haltestelle. Vgl. 7.5.1.
    let stopPlaceRef: String
    /// Name der Haltestelle für Fahrgastinformation.
    let stopPlaceName: InternationalText
    // TODO: Replace these quotation marks with normal ones
    // TODO: Make sure all comments end with a '.'
    /// Namenszusatz, der bei Platzmangel evtl. auch weggelassen werden kann, z. B.: „Messe/Exhibition Center“.
    let nameSuffix: InternationalText?
    
    /// Privater Code für diese Haltestelle in einem anderen Schlüsselsystem.
    let privateCodes: [PrivateCode]?
    /// Referenz auf die Ortschaft, zu der diese Haltestelle gehört. Vgl. 7.5.1.
    let localityRef: String?
    
    // MARK: StopAttributes
    /// Rollstuhltauglichkeit dieses Haltepunkts
    let wheelchairAccessible: Bool?
    /// Angabe zur Beleuchtung dieses Haltepunkts
    let lighting: Bool?
    /// Angabe, ob dieser Haltepunkt Witterungsschutz bietet (vor Regen, Schnee, Sturm etc.).
    let covered: Bool?
    
    init(
        stopPlaceRef: String,
        stopPlaceName: InternationalText,
        nameSuffix: InternationalText? = nil,
        privateCodes: [PrivateCode]? = nil,
        localityRef: String? = nil,
        wheelchairAccessible: Bool? = nil,
        lighting: Bool? = nil,
        covered: Bool? = nil
    ) {
        self.stopPlaceRef = stopPlaceRef
        self.stopPlaceName = stopPlaceName
        self.nameSuffix = nameSuffix
        self.privateCodes = privateCodes
        self.localityRef = localityRef
        self.wheelchairAccessible = wheelchairAccessible
        self.lighting = lighting
        self.covered = covered
    }
}
