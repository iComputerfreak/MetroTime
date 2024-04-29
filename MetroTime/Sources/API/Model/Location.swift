// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modell eines allgemeinen Ortspunkts (Haltepunkt, Haltestelle, Koordinatenposition, Ortschaft, POI oder Adresse).
struct Location: Codable {
    enum CodingKeys: String, CodingKey {
        case stopPoint = "StopPoint"
        case stopPlace = "StopPlace"
        case locality = "Locality"
        case pointOfInterest = "PointOfInterest"
        case address = "Address"
        case locationName = "LocationName"
        case geoPosition = "GeoPosition"
    }
    
    /// Angaben zu einem Haltepunkt. Vgl. 7.5.2.
    let stopPoint: StopPoint?
    /// Angaben zur Haltestelle. Vgl. 7.5.3.
    let stopPlace: StopPlace?
    /// Angaben zu einer Stadt/Ortschaft. Vgl. 7.5.4.
    let locality: Locality?
    /// Angaben zu einem POI. Vgl. 7.5.5.
    let pointOfInterest: PointOfInterest?
    ///  Angaben zu einer Adresse. Vgl. 7.5.9.
    let address: Address?
    
    /// Name oder Bezeichnung des Ortspunkts
    let locationName: InternationalText
    /// Koordinatenposition. Vgl. 7.2.3.
    let geoPosition: GeoPosition
    
    // TODO: Attributes
}
