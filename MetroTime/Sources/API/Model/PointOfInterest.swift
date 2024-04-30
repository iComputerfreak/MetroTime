// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modellierung einer POI-Kategorie
struct OSMTag: Codable {
    enum CodingKeys: String, CodingKey {
        case tag = "Tag"
        case value = "Value"
    }
    
    /// Name des OpenStreetMap-Tags (z.B. amenity, leisure, tourism, bike, ...)
    let tag: String
    /// Wert des OpenStreetMap-Tags (z.B. yes, hostel, charging_station, ...)
    let value: String
}

/// Modellierung einer POI-Kategorie-Liste
struct PointOfInterestCategory: Codable {
    enum CodingKeys: String, CodingKey {
        case osmTags = "OsmTag"
    }
    
    /// Liste der POI-Kategorien, definiert durch Schlüssel-Wert-Paare wie in OpenStreetMap.7 Vgl. 7.5.7
    let osmTags: [OSMTag]
}

/// Modellierung eines wichtigen Punkts (POI).
struct PointOfInterest: Codable {
    enum CodingKeys: String, CodingKey {
        case pointOfInterestCode = "PointOfInterestCode"
        case pointOfInterestName = "PointOfInterestName"
        case nameSuffix = "NameSuffix"
        case pointOfInterestCategory = "PointOfInterestCategory"
        case privateCodes = "PrivateCode"
        case localityRef = "LocalityRef"
    }
    
    /// Identifikator des wichtigen Punkts.
    let pointOfInterestCode: String
    /// Name des wichtigen Punkts für Fahrgastinformation
    let pointOfInterestName: InternationalText
    /// Namenszusatz, der bei Platzmangel evtl. auch weggelassen werden kann, z. B.: „Messe/Exhibition Center“.
    let nameSuffix: InternationalText?
    /// Kategorien, die diesem POI zugeordnet sind. Vgl. 7.5.6. Falls mehrere aufgeführt sind, sind sie nach absteigender Relevanz sortiert.
    let pointOfInterestCategory: PointOfInterestCategory?
    /// Privater Code für diesen Haltepunkt in einem anderen Schlüsselsystem.
    let privateCodes: [PrivateCode]?
    /// Referenz auf die zugeordnete Ortschaft, zu der dieser wichtige Punkt gehört. Vgl. 7.5.1.
    let localityRef: String?
}
