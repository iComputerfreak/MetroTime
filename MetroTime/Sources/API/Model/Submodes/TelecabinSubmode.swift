// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Lift- und Aufzugsarten (nach TPEG pti_table 09).
enum TelecabinSubmode: Codable {
    case unknown
    case undefined
    case telecabin
    case cableCar
    case lift
    case chairLift
    case dragLift
    case telecabinLink
}
