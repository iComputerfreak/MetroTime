// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Geographische Position in WGS84
struct GeoPosition: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
    }
    
    /// Geographische Länge bzgl. des Greenwich-Meridians. Wertebereich von -180 Grad (West) bis +180 Grad (Ost).
    let latitude: Double
    /// Geographische Breite bzgl. des Äquators. Wertebereich von -90 Grad (Süden) bis +90 Grad (Norden).
    let longitude: Double
    /// Höhe über dem Meeresspiegel in Meter.
    let altitude: Double?
}
