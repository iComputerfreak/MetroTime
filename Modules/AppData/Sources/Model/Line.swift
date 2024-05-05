// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain

public  struct Line: LineProtocol {
    public let id: String
    public let name: String
    public let directionID: String
    public let direction: String
    
    // TODO: Could we get the "Straßenbahn" prefix from the mode and remove it like this?
    /*
     <Mode>
         <PtMode>tram</PtMode>
         <TramSubmode>cityTram</TramSubmode>
         <Name>
             <Text>Straßenbahn</Text>
             <Language>de</Language>
         </Name>
     </Mode>
     <PublishedLineName>
         <Text>Straßenbahn 5</Text>
         <Language>de</Language>
     </PublishedLineName>
     */
    public init(id: String, name: String, directionID: String, direction: String) {
        self.id = id
        self.name = name
        self.directionID = directionID
        self.direction = direction
    }
}
