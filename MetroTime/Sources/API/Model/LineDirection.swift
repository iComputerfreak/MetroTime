// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Linien-ID, evtl. verfeinert auf eine Richtung
struct LineDirection: Codable {
    enum CodingKeys: String, CodingKey {
        case lineRef = "LineRef"
        case directionRef = "DirectionRef"
    }
    
    /// Referenz auf die Linie (vgl. 7.4.1).
    let lineRef: String
    /// Referenz auf die Linienrichtung. Vgl. 7.4.1.
    let directionRef: String?
    
    init(lineRef: String, directionRef: String? = nil) {
        self.lineRef = lineRef
        self.directionRef = directionRef
    }
}
