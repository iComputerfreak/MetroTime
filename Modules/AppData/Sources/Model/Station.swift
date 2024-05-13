// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain

public struct Station: StationProtocol {
    public let id: String
    public let name: String
    public let localityID: String
    public let localityName: String
    public let latitude: Double
    public let longitude: Double
    public var altitude: Double?
    
    public init(id: String, name: String, localityID: String, locality: String, latitude: Double, longitude: Double, altitude: Double? = nil) {
        self.id = id
        self.name = name
        self.localityID = localityID
        self.localityName = locality
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
    }
}
