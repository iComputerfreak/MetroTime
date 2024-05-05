// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Seilbahnen (nach TPEG pti_table 10).
enum FunicularSubmode: String, Codable {
    case unknown
    case undefined
    case funicular
    case allFunicularServices
    case undefinedFunicular
}
