// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

// TODO: Implement
public final class RemoteTriasService: TriasService {
    public init() {}
    
    public func fetchStations(by name: String) async throws -> [any StationProtocol] {
        []
    }
    
    public func fetchStation(by id: String) async throws -> any StationProtocol {
        Station(id: "", name: "")
    }
    
    public func fetchDepartures(at station: any StationProtocol) async throws -> [any DepartureProtocol] {
        []
    }
    
    public func fetchLines(at station: any StationProtocol) async throws -> [any LineProtocol] {
        []
    }
}
