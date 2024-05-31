// Copyright © 2024 Jonas Frey. All rights reserved.

import Combine
import Foundation

public protocol UserDefaultsService: ObservableObject {
    // MARK: - Favorite Stations and Lines
    func getFavoriteStations() -> [any StationProtocol]
    func getFavoriteLines() -> [String: [any LineProtocol]]
    func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol]
    func addFavoriteLine(_ line: any LineProtocol, at station: any StationProtocol)
    func resetFavorites()
    
    // MARK: - Number of Rows per Station
    func getNumberOfRowsPerStation() -> Int
    func setNumberOfRowsPerStation(_ numberOfRows: Int)
}

public extension UserDefaultsService {
    func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol] {
        getFavoriteLines()[station.id, default: []]
    }
}
