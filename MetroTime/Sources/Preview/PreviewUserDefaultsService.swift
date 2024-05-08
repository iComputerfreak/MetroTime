// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

final class PreviewUserDefaultsService: UserDefaultsService {
    var stations: [any StationProtocol] = [
        Station(id: "de:08212:508", name: "Otto-Sachs-Straße", localityID: "8212000:15", locality: "Karlsruhe"),
        Station(id: "de:08212:1004", name: "Europaplatz/Postgalerie (U)", localityID: "8212000:15", locality: "Karlsruhe"),
    ]
    
    var lines: [String: [any LineProtocol]] = [
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
        if !stations.contains(where: { station in
            station.id == station.id
        }) {
            stations.append(station)
        }
        
        if !lines.contains(where: { line in
            line.key == station.id
        }) {
            lines[station.id] = [line]
        }
        
        lines[station.id]?.append(line)
    }
    
    func resetFavorites() {
        stations = []
        lines = [:]
    }
}
