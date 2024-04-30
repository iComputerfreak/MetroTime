// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Straßenbahnen (nach TPEG pti_table 06).
enum TramSubmode: Codable {
    case unknown
    case undefined
    case cityTram
    case localTram
    case regionalTram
    case sightseeingTram
    case shuttleTram
}
