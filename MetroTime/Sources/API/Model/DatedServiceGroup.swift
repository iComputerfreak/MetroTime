// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Gruppe zur Beschreibung der Fahrt einer Linie an einem bestimmten Tag
struct DatedServiceGroup: Codable {
    enum CodingKeys: String, CodingKey {
        case operatingDayRef = "OperatingDayRef"
        case vehicleRef = "VehicleRef"
        case journeyRef = "JourneyRef"
        case lineRef = "LineRef"
        case directionRef = "DirectionRef"
        case mode = "Mode"
        case publishedLineName = "PublishedLineName"
        case operatorRef = "OperatorRef"
        case routeDescription = "RouteDescription"
        case vias = "Via"
        case attributes = "Attribute"
    }
    
    /// Betriebstag der Fahrt. Vgl. 7.4.1
    let operatingDayRef: String?
    /// Fahrzeug-ID. Vgl. 7.4.1
    let vehicleRef: String?
    /// Fahrt-ID. Vgl. 7.4.1.
    let journeyRef: String?
    /// Linien-ID. Vgl. 7.4.1
    let lineRef: String?
    /// Richtungs-ID. Vgl. 7.4.1.
    let directionRef: String?
    /// Verkehrsmitteltyp. Vgl. 7.3.4.
    let mode: Mode?
    /// Liniennummer oder –name, wie in der Öffentlichkeit bekannt
    let publishedLineName: InternationalText?
    /// Operator-ID. Vgl. 7.4.1.
    let operatorRef: String?
    /// Beschreibung des Fahrwegs
    let routeDescription: InternationalText?
    /// Wichtige Halte auf dem Fahrweg. Vgl. 7.6.1.
    let vias: [ServiceViaPoint]?
    /// Hinweise und Attribute (mit Klassifikationen) zur Fahrt. Vgl. 7.4.10
    let attributes: [GeneralAttribute]?
}
