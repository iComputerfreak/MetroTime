// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// A `ServiceArrival` or a `ServiceDeparture`
struct ServiceArrivalOrDeparture: Codable {
    enum CodingKeys: String, CodingKey {
        case timetabledTime = "TimetabledTime"
        case recordedAtTime = "RecordedAtTime"
        case estimatedTime = "EstimatedTime"
        case estimatedTimeLow = "EstimatedTimeLow"
        case estimatedTimeHigh = "EstimatedTimeHigh"
    }
    
    /// Ankunfts-/Abfahrtszeit nach Fahrplan
    let timetabledTime: Date?
    /// Tatsächliche Ankunfts-/Abfahrtszeit
    let recordedAtTime: Date?
    /// Erwartete Ankunfts-/Abfahrtszeit
    let estimatedTime: Date?
    /// Untere Schranke für erwartete Ankunfts-/Abfahrtszeit
    let estimatedTimeLow: Date?
    /// Obere Schranke für erwartete Ankunfts-/Abfahrtszeit
    let estimatedTimeHigh: Date?
}
