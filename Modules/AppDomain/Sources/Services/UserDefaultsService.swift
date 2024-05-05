// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public protocol UserDefaultsService {
    func getFavoriteStations() -> [any StationProtocol]
    func getFavoriteLines() -> [String: [any LineProtocol]]
    func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol]
}
