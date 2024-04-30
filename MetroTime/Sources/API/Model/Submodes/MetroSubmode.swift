// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Untergrundbahnen (nach TPEG pti_table 04).
enum MetroSubmode: Codable {
    case unknown
    case undefined
    case metro
    case tube
    case urbanRailway
}
