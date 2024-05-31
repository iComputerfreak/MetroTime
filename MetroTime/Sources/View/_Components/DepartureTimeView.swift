// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Factory
import SwiftUI

struct DepartureTimeView: View {
    private enum Constants {
        static let lateDepartureTime: TimeInterval = 2 * .minute
    }
    
    let departure: any DepartureProtocol
    
    var departureDate: Date {
        departure.estimatedDeparture ?? departure.plannedDeparture
    }
    
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
    
    var body: some View {
        // TODO: Finish implementation
        Text(departureDate.formatted(date: .omitted, time: .shortened))
            .foregroundStyle(departureColor)
    }
}

#Preview {
    List {
        HStack {
            Text(verbatim: "4 Durlach")
            Spacer()
            DepartureTimeView(departure: PreviewTriasService.default.allDepartures.first!)
        }
    }
}
