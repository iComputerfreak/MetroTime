// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Represents the departure of a specific line at a station
public protocol DepartureProtocol: Codable, Identifiable {
    var id: String { get }
    var line: String { get }
    var direction: String { get }
    var plannedDeparture: Date { get }
    var estimatedDeparture: Date { get }
}
