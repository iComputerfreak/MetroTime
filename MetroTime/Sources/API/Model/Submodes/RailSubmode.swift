// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Züge (nach TPEG pti_table 02).
enum RailSubmode: Codable {
    case unknown
    case undefined
    case localRail
    case highSpeedRail
    case suburbanRailway
    case regionalRail
    case interRegionalRail
    case longDistanceRail
    case internationalRail
    case sleeperRailService
    case nightRail
    case carTransportRailService
    case touristRailway
    case railShuttle
    case replacementRailService
    case specialTrain
    case crossCountryRail
    case rackAndPinionRailway
}
