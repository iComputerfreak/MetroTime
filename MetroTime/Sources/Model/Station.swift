// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Represents a stop poing, i.e., a place where a train or tram stops
struct Station: Codable, Identifiable {
    let id: String
    let name: String
}
