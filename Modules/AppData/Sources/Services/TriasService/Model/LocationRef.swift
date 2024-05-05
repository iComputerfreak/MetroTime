// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Referenz auf einen allgemeinen Ortspunkt (Haltepunkt, Haltestelle, Koordinatenposition, Ortschaft oder POI).
struct LocationRef: Codable {
    enum CodingKeys: String, CodingKey {
        case stopPointRef = "StopPointRef"
        case stopPlaceRef = "StopPlaceRef"
        case geoPosition = "GeoPosition"
        case localityRef = "LocalityRef"
        case pointOfInterestRef = "PointOfInterestRef"
        case addressRef = "AddressRef"
        case locationName = "LocationName"
    }
    
    /// Referenz auf einen Code für einen Haltepunkt. Vgl. 7.5.1.
    let stopPointRef: String?
    /// Referenz auf einen Code für eine Haltestelle. Vgl. 7.5.1.
    let stopPlaceRef: String?
    /// Koordinatenposition
    let geoPosition: GeoPosition?
    /// Referenz auf einen Code für eine Ortschaft. Vgl. 7.5.1
    let localityRef: String?
    /// Referenz auf einen Code für einen POI. Vgl. 7.5.1
    let pointOfInterestRef: String?
    /// Referenz auf eine Adresse. Vgl. 7.5.1.
    let addressRef: String?
    
    /// Name oder Bezeichnung des Ortspunkts
    let locationName: InternationalText
    
    init(
        stopPointRef: String? = nil,
        stopPlaceRef: String? = nil,
        geoPosition: GeoPosition? = nil,
        localityRef: String? = nil,
        pointOfInterestRef: String? = nil,
        addressRef: String? = nil,
        locationName: InternationalText
    ) {
        self.stopPointRef = stopPointRef
        self.stopPlaceRef = stopPlaceRef
        self.geoPosition = geoPosition
        self.localityRef = localityRef
        self.pointOfInterestRef = pointOfInterestRef
        self.addressRef = addressRef
        self.locationName = locationName
    }
}
