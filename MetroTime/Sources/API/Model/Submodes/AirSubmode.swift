// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Luftverkehrsmittel (nach TPEG pti_table 08).
enum AirSubmode: String, Codable {
    case unknown
    case undefined
    case internationalFlight
    case domesticFlight
    case intercontinentalFlight
    case domesticScheduledFlight
    case shuttleFlight
    case intercontinentalCharterFlight
    case internationalCharterFlight
    case roundTripCharterFlight
    case sightseeingFlight
    case helicopterService
    case domesticCharterFlight
    case schengenAreaFlight
    case airshipService
    case shortHaulInternationalFlight
    case canalBarge
}
