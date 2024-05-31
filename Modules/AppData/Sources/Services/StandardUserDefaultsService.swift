// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation
import JamitFoundation
import UserDefaults

public final class StandardUserDefaultsService: UserDefaultsService {
    @UserDefault(key: "favoriteStations", defaultValue: [])
    private var favoriteStations: [Station]
    
    // Keyed by Station.id
    @UserDefault(key: "favoriteLines", defaultValue: [:])
    private var favoriteLines: [String: [Line]]
    
    public init() {}
    
    public func getFavoriteStations() -> [any StationProtocol] {
        favoriteStations
    }
    
    public func getFavoriteLines() -> [String: [any LineProtocol]] {
        favoriteLines
    }
    
    public func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol]? {
        favoriteLines[station.id]
    }
    
    public func addFavoriteLine(_ line: any LineProtocol, at station: any StationProtocol) {
        guard
            let station = station as? Station,
            let line = line as? Line
        else { return }
        
        if !favoriteStations.contains(where: { $0.id == station.id }) {
            favoriteStations.append(station)
        }
        favoriteLines[station.id, default: []].append(line)
    }
    
    public func resetFavorites() {
        favoriteStations = []
        favoriteLines = [:]
    }
}
