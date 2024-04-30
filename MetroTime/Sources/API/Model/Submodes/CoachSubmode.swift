// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Unter-Klassifizierung der Überlandbusse (nach TPEG pti_table 03).
enum CoachSubmode: Codable {
    case unknown
    case undefined
    case internationalCoach
    case nationalCoach
    case shuttleCoach
    case regionalCoach
    case specialCoach
    case sightseeingCoach
    case touristCoach
    case commuterCoach
}
