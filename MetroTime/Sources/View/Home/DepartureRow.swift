// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import SwiftUI

struct DepartureRow: View {
    let departure: any DepartureProtocol
    
    // TODO: Styling
    var body: some View {
        HStack {
            Text(verbatim: "\(departure.lineName) \(departure.direction)")
            Spacer()
            DepartureTimeView(departure: departure)
        }
    }
}

#Preview {
    List {
        // TODO: Better test data
        ForEach(PreviewTriasService().allDepartures, id: \.id) { departure in
            DepartureRow(departure: departure)
        }
    }
}
