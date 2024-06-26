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
        case attributes = "Attribute"
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
    
    /// Attribute, die dem Ortspunkt zugeordnet sind. Vgl. 7.4.10
    let attributes: [GeneralAttribute]?
    
    init(
        stopPoint: StopPoint? = nil,
        stopPlace: StopPlace? = nil,
        locality: Locality? = nil,
        pointOfInterest: PointOfInterest? = nil,
        address: Address? = nil,
        locationName: InternationalText,
        geoPosition: GeoPosition,
        attributes: [GeneralAttribute]? = nil
    ) {
        self.stopPoint = stopPoint
        self.stopPlace = stopPlace
        self.locality = locality
        self.pointOfInterest = pointOfInterest
        self.address = address
        self.locationName = locationName
        self.geoPosition = geoPosition
        self.attributes = attributes
    }
}
