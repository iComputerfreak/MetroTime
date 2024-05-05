// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain

public struct Station: StationProtocol {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
