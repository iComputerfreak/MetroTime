// Copyright © 2024 Jonas Frey. All rights reserved.

public protocol TriasService {
    func fetchStations(byName name: String) async throws -> [any StationProtocol]
    func fetchDepartures(at station: any StationProtocol, lines: [any LineProtocol]?) async throws -> [any DepartureProtocol]
    func fetchDepartures(at stations: [any StationProtocol], lines: [String: [any LineProtocol]]?) async throws -> [String: [any DepartureProtocol]]
    func fetchLines(at station: any StationProtocol) async throws -> [any LineProtocol]
}
