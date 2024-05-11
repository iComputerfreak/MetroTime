// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import OSLog
import SwiftUI

final class PreviewUserDefaultsService: UserDefaultsService {
    @Published var stations: [any StationProtocol] = [
        Station(id: "de:08212:508", name: "Otto-Sachs-Straße", localityID: "8212000:15", locality: "Karlsruhe"),
        Station(id: "de:08212:1004", name: "Europaplatz/Postgalerie (U)", localityID: "8212000:15", locality: "Karlsruhe"),
    ]
    
    @Published var lines: [String: [any LineProtocol]] = [
        // Otto-Sachs-Straße
        "de:08212:508": [
            Line(id: "kvv:21005:E:R", name: "Straßenbahn 5", directionID: "inward", direction: "Durlach Bahnhof"),
        ],
        // Europaplatz/Postgalerie (U)
        "de:08212:1004": [
            Line(id: "kvv:21001:E:H", name: "Straßenbahn 1", directionID: "outward", direction: "Heide"),
        ],
    ]
    
    func getFavoriteStations() -> [any StationProtocol] {
        stations
    }
    
    func getFavoriteLines() -> [String: [any LineProtocol]] {
        lines
    }
    
    func addFavoriteLine(_ line: any LineProtocol, at station: any StationProtocol) {
        if !stations.contains(where: { currentStation in
            currentStation.id == station.id
        }) {
            Logger.userDefaultsService.debug("Adding station \(station.name)")
            stations.append(station)
        }
        
        if !lines.contains(where: { entry in
            entry.key == station.id
        }) {
            lines[station.id] = []
        }
        
        Logger.userDefaultsService.debug("Adding line \(line.name)")
        lines[station.id]?.append(line)
    }
    
    func resetFavorites() {
        stations = []
        lines = [:]
    }
}
