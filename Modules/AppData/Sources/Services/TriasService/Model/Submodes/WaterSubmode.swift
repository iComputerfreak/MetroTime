// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Wasserverkehrsmittel (nach TPEG pti_table 07).
enum WaterSubmode: String, Codable {
    case unknown
    case undefined
    case internationalCarFerry
    case nationalCarFerry
    case regionalCarFerry
    case localCarFerry
    case internationalPassengerFerry
    case nationalPassengerFerry
    case regionalPassengerFerry
    case localPassengerFerry
    case postBoat
    case trainFerry
    case roadFerryLink
    case airportBoatLink
    case highSpeedVehicleService
    case highSpeedPassengerService
    case sightseeingService
    case schoolBoat
    case cableFerry
    case riverBus
    case scheduledFerry
    case shuttleFerryService
}
