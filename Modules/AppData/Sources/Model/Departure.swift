// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

struct Departure: DepartureProtocol {
    let id: String
    let line: String
    let direction: String
    let plannedDeparture: Date
    let estimatedDeparture: Date
}
