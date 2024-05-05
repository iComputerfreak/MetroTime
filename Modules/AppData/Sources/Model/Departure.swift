// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

public struct Departure: DepartureProtocol {
    public let id: String
    public let line: String
    public let direction: String
    public let plannedDeparture: Date
    public let estimatedDeparture: Date
    
    public init(id: String, line: String, direction: String, plannedDeparture: Date, estimatedDeparture: Date) {
        self.id = id
        self.line = line
        self.direction = direction
        self.plannedDeparture = plannedDeparture
        self.estimatedDeparture = estimatedDeparture
    }
}
