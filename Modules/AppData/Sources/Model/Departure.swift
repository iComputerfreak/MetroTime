// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

public struct Departure: DepartureProtocol {
    public let id: String
    public let stationID: String
    public let lineID: String
    public let lineName: String
    public let direction: String
    public let plannedDeparture: Date
    public let estimatedDeparture: Date?
    
    public init(id: String, stationID: String, lineID: String, lineName: String, direction: String, plannedDeparture: Date, estimatedDeparture: Date?) {
        self.id = id
        self.stationID = stationID
        self.lineID = lineID
        self.lineName = lineName
        self.direction = direction
        self.plannedDeparture = plannedDeparture
        self.estimatedDeparture = estimatedDeparture
    }
}
