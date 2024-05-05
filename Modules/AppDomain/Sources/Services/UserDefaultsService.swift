// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public protocol UserDefaultsService {
    func getFavoriteStations() -> [any StationProtocol]
    func getFavoriteLines() -> [String: [any LineProtocol]]
    func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol]
    func addFavoriteLine(_ line: any LineProtocol, at station: any StationProtocol)
    func resetFavorites()
}

public extension UserDefaultsService {
    func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol] {
        getFavoriteLines()[station.id, default: []]
    }
}
