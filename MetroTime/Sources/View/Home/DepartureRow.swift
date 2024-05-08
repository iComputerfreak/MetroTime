// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import SwiftUI

struct DepartureRow: View {
    private enum Constants {
        static let lateDepartureTime: TimeInterval = 2 * .minute
    }
    
    let departure: any DepartureProtocol
    
    var departureColor: Color {
        guard let estimatedDeparture = departure.estimatedDeparture else {
            return .gray
        }
        // If the estimated departure is more than 2 minutes behind the planned departure
        if estimatedDeparture > departure.plannedDeparture.addingTimeInterval(Constants.lateDepartureTime) {
            return .red
        }
        
        // If the estimated departure is more than 2 minutes earlier than the planned departure
        if estimatedDeparture < departure.plannedDeparture.addingTimeInterval(-Constants.lateDepartureTime) {
            return .orange
        }
        
        return .primary
    }
    
    var departureDate: Date {
        departure.estimatedDeparture ?? departure.plannedDeparture
    }
    
    // TODO: Styling
    var body: some View {
        HStack {
            Text(verbatim: "\(departure.lineName) \(departure.direction)")
            Spacer()
            Text(departureDate.formatted(date: .omitted, time: .shortened))
                .foregroundStyle(departureColor)
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
