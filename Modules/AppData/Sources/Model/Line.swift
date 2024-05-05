// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain

public  struct Line: LineProtocol {
    public let id: String
    public let name: String
    public let directionID: String
    public let direction: String
    
    public init(id: String, name: String, directionID: String, direction: String) {
        self.id = id
        self.name = name
        self.directionID = directionID
        self.direction = direction
    }
}
