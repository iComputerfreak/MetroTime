// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

public final class RemoteUserDefaultsService: UserDefaultsService {
    public init() {}
    
    public func getFavoriteStations() -> [any StationProtocol] {
        []
    }
    
    public func getFavoriteLines() -> [String: [any LineProtocol]] {
        [:]
    }
    
    public func getFavoriteLines(at station: any StationProtocol) -> [any LineProtocol] {
        []
    }
    
    public func addFavoriteLine(_ line: any LineProtocol, at station: any StationProtocol) {
        // TODO: Implement
    }
    
    public func resetFavorites() {
        // TODO: Implement
    }
}
