// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Definiert einen geografischen Filter
struct GeoRestrictions: Codable {
    enum CodingKeys: String, CodingKey {
        case circle = "Circle"
        case rectangle = "Rectangle"
        case area = "Area"
    }
    
    /// Der Filter wird durch einen Kreis definiert. Vgl. 8.3.4
    let circle: GeoCircle?
    /// Der Filter wird durch ein Rechteck definiert. Vgl. 8.3.5
    let rectangle: GeoRectangle?
    /// Der Filter wird durch ein Polygon definiert. Vgl. 8.3.6.
    let area: GeoArea?
}
