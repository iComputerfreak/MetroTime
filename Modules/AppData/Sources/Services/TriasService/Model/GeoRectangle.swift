// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Definiert ein geografisches Rechteck.
struct GeoRectangle: Codable {
    enum CodingKeys: String, CodingKey {
        case upperLeft = "UpperLeft"
        case lowerRight = "LowerRight"
    }
    
    /// Linke obere Ecke des Rechtecks. Vgl. 7.2.3.
    let upperLeft: GeoPosition
    /// Rechte untere Ecke des Rechtecks. Vgl. 7.2.3.
    let lowerRight: GeoPosition
}
