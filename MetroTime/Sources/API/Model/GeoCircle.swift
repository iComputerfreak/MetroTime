// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Definiert einen geografischen Kreis
struct GeoCircle: Codable {
    enum CodingKeys: String, CodingKey {
        case center = "Center"
        case radius = "Radius"
    }
    
    /// Zentrum des Kreises. Vgl. 7.2.3
    let center: GeoPosition
    /// Radius des Kreises in Metern.
    let radius: Int
}
