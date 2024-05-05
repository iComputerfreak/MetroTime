// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain

public struct Station: StationProtocol {
    public let id: String
    public let name: String
    public let localityID: String
    public let localityName: String
    
    public init(id: String, name: String, localityID: String, locality: String) {
        self.id = id
        self.name = name
        self.localityID = localityID
        self.localityName = locality
    }
}
