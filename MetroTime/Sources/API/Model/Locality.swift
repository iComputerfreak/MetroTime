// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modellierung einer Ortschaft/Stadt.
struct Locality: Codable {
    enum CodingKeys: String, CodingKey {
        case localityCode = "LocalityCode"
        case localityName = "LocalityName"
        case privateCodes = "PrivateCode"
        case parentRef = "ParentRef"
        case points = "Point"
    }
    
    /// Identifikator der Ortschaft/Stadt. Vgl. 7.5.1.
    let localityCode: String
    /// Name der Ortschaft für Fahrgastinformation.
    let localityName: InternationalText
    /// Privater Code für diesen Haltepunkt in einem anderen Schlüsselsystem.
    let privateCodes: [PrivateCode]?
    /// Referenz auf eine übergeordnete Ortschaft, zu der diese Ortschaft gehört, z. B. Beziehung Stadtteil zu Stadt. Vgl. 7.5.1.
    let parentRef: String?
    /// Polygonzug, der das Gebiet der Ortschaft beschreibt.
    let points: [GeoPosition]
    
    init(
        localityCode: String,
        localityName: InternationalText,
        privateCodes: [PrivateCode]?,
        parentRef: String?,
        points: [GeoPosition]
    ) {
        self.localityCode = localityCode
        self.localityName = localityName
        self.privateCodes = privateCodes
        self.parentRef = parentRef
        self.points = points
    }
}
