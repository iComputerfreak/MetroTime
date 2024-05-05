// Copyright © 2024 Jonas Frey. All rights reserved.

public protocol TriasService {
    func fetchStations(byName name: String) async throws -> [any StationProtocol]
    func fetchStation(byID id: String) async throws -> any StationProtocol
    func fetchDepartures(at station: any StationProtocol) async throws -> [any DepartureProtocol]
    func fetchLines(at station: any StationProtocol) async throws -> [any LineProtocol]
}
