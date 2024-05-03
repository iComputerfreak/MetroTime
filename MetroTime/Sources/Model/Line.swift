// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Represents a specific metro / tram / train line with a direction
struct Line: Codable, Identifiable {
    let id: String
    let name: String
    let directionID: String
    let direction: String
}
