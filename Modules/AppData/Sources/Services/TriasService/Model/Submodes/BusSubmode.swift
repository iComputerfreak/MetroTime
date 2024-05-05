// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Busse (nach TPEG pti_table 05).
enum BusSubmode: String, Codable {
    case unknown
    case undefined
    case localBus
    case regionalBus
    case expressBus
    case nightBus
    case postBus
    case specialNeedsBus
    case mobilityBus
    case mobilityBusForRegisteredDisabled
    case sightseeingBus
    case shuttleBus
    case schoolBus
    case schoolAndPublicServiceBus
    case railReplacementBus
    case demandAndResponseBus
    case airportLinkBus
}
