// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import AppNetworking
import Foundation
import JFUtils

final class PreviewTriasService: TriasService {
    private let allStations: [any StationProtocol] = [
        Station(id: "de:08212:508", name: "Otto-Sachs-Straße", localityID: "8212000:15", locality: "Karlsruhe"),
        Station(id: "de:08212:1004", name: "Europaplatz/Postgalerie (U)", localityID: "8212000:15", locality: "Karlsruhe"),
        Station(id: "de:08212:401", name: "Karl-Wilhelm-Platz", localityID: "8212000:15", locality: "Karlsruhe"),
    ]
    
    private let allLines: [String: [any LineProtocol]] = [
        // Otto-Sachs-Straße
        "de:08212:508": [
            Line(id: "kvv:21005:E:R", name: "5", directionID: "inward", direction: "Durlach Bahnhof"),
        ],
        // Europaplatz/Postgalerie (U)
        "de:08212:1004": [
            Line(id: "kvv:21001:E:H", name: "1", directionID: "outward", direction: "Heide"),
            Line(id: "kvv:22305:E:R", name: "S5", directionID: "inward", direction: "Pforzheim Hbf"),
        ],
        // Karl-Wilhelm-Platz
        "de:08212:401": [
            Line(id: "kvv:21004:E:R", name: "4", directionID: "inward", direction: "Waldstadt"),
        ],
    ]
    
    func fetchStations(byName name: String) async throws -> [any StationProtocol] {
        print("Searching for '\(name)'...")
        return allStations.filter { $0.name.localizedCaseInsensitiveContains(name) }
    }
    
    func fetchStation(byID id: String) async throws -> any StationProtocol {
        guard let station = allStations.first(where: \.id, equals: id) else {
            throw APIError.unexpectedError
        }
        return station
    }
    
    func fetchDepartures(at station: any StationProtocol) async throws -> [any DepartureProtocol] {
        try await Task.sleep(for: .seconds(0.5))
        
        guard let lines = allLines[station.id] else {
            throw APIError.unexpectedError
        }
        var plannedDepartures: [Date] = [
            Date().addingTimeInterval(5 * .minute),
            Date().addingTimeInterval(13 * .minute),
        ]
        var estimatedDepartures: [Date] = [
            Date().addingTimeInterval(4 * .minute),
            Date().addingTimeInterval(19 * .minute),
        ]
        assert(plannedDepartures.count == estimatedDepartures.count)
        assert(
            plannedDepartures.count == allLines.map({ $0.value.count }).max(),
            "Not enough departure dates for all lines available. Please extend the above array."
        )
        return lines.map { line in
            Departure(
                id: UUID().uuidString,
                stationID: station.id,
                lineID: line.id,
                lineName: line.name,
                direction: line.direction,
                plannedDeparture: plannedDepartures.removeFirst(),
                estimatedDeparture: estimatedDepartures.removeFirst()
            )
        }
    }
    
    func fetchDepartures(at stations: [any StationProtocol]) async throws -> [any DepartureProtocol] {
        var departures: [any DepartureProtocol] = []
        for station in stations {
            try await departures.append(contentsOf: fetchDepartures(at: station))
        }
        return departures
    }
    
    func fetchLines(at station: any StationProtocol) async throws -> [any LineProtocol] {
        allLines[station.id, default: []]
    }
}
