// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Represents a stop poing, i.e., a place where a train or tram stops
public protocol StationProtocol: Codable, Identifiable {
    var id: String { get }
    var name: String { get }
}
