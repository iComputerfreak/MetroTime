// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct Departure: Codable, Identifiable {
    let id: String
    let line: String
    let direction: String
    let plannedDeparture: Date
    let estimatedDeparture: Date
}
