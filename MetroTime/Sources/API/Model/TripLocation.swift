// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fahrplanfahrt als momentaner Aufenthaltsort eines Fahrgasts
struct TripLocation: Codable {
    enum CodingKeys: String, CodingKey {
        case operatingDayRef = "OperatingDayRef"
        case journeyRef = "JourneyRef"
        case lineRef = "LineRef"
        case directionRef = "DirectionRef"
    }
    
    /// Betriebstag der Fahrt. Vgl. 7.4.1.
    let operatingDayRef: String
    /// Fahrt-ID. Vgl. 7.4.1.
    let journeyRef: String
    /// Linien-ID. Vgl. Vgl. 7.4.1.
    let lineRef: String
    /// Richtungs-ID. Vgl. 7.4.1.
    let directionRef: String
}
