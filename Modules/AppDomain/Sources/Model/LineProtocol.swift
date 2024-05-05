// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Represents a specific metro / tram / train line with a direction
public protocol LineProtocol: Codable, Identifiable {
    var id: String { get }
    var name: String { get }
    var directionID: String { get }
    var direction: String { get }
}
