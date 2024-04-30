// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Definiert ein geografisches Polygon
struct GeoArea: Codable {
    enum CodingKeys: String, CodingKey {
        case polylinePoints = "PolylinePoints"
    }
    
    /// Eckpunkte des Polygons. Vgl. 7.2.3
    let polylinePoints: [GeoPosition]
}
