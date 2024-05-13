// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct StationRow: View {
    let station: any StationProtocol
    
    var isAdded: Bool {
        station.id == "1"
    }
    
    var body: some View {
        Text(station.name)
    }
}

#Preview {
    List {
        StationRow(station: Station(id: "1", name: "Europaplatz/Postgalerie (U)", localityID: "", locality: "", latitude: 0, longitude: 0, altitude: nil))
        StationRow(station: Station(id: "2", name: "Europaplatz/Postgalerie (U)", localityID: "", locality: "", latitude: 0, longitude: 0, altitude: nil))
        StationRow(station: Station(id: "3", name: "Europaplatz/Postgalerie (U)", localityID: "", locality: "", latitude: 0, longitude: 0, altitude: nil))
    }
}
