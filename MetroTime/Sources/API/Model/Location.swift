// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modell eines allgemeinen Ortspunkts (Haltepunkt, Haltestelle, Koordinatenposition, Ortschaft, POI oder Adresse).
struct Location: Decodable {
    enum CodingKeys: String, CodingKey {
        case stopPoint = "StopPoint"
        case locationName = "LocationName"
        case geoPosition = "GeoPosition"
    }
    
    // TODO: StopPoint, StopPlace, Locality, PointOfInterest, or Address
    /// Angaben zu einem Haltepunkt. Vgl. 7.5.2.
    let stopPoint: String? // TODO: StopPoint
    
    // TODO: Comments
    /// Name oder Bezeichnung des Ortspunkts
    let locationName: InternationalText
    /// Koordinatenposition. Vgl. 7.2.3.
    let geoPosition: GeoPosition
    
    // TODO: Attributes
}
