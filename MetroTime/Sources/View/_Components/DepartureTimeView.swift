// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Factory
import SwiftUI

struct DepartureTimeView: View {
    private enum Constants {
        /// How much a departure has to be early for the view to color it orange
        static let earlyDepartureTime: TimeInterval = 2 * .minute
        /// How much a departure has to be late for the view to color it red
        static let lateDepartureTime: TimeInterval = 2 * .minute
        /// When to start displaying the countdown instead of the full time
        static let countdownStart: TimeInterval = 10 * .minute
    }
    
    let departure: any DepartureProtocol
    
    private let relativeDateTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .numeric
        formatter.unitsStyle = .short
        return formatter
    }()
    
    var departureDate: Date {
        departure.estimatedDeparture ?? departure.plannedDeparture
    }
    
    var departureColor: Color {
        guard let estimatedDeparture = departure.estimatedDeparture else {
            return .gray
        }
        // If the estimated departure is more than 2 minutes behind the planned departure
        if estimatedDeparture >= departure.plannedDeparture.addingTimeInterval(Constants.lateDepartureTime) {
            return .red
        }
        
        // If the estimated departure is more than 2 minutes earlier than the planned departure
        if estimatedDeparture <= departure.plannedDeparture.addingTimeInterval(-Constants.earlyDepartureTime) {
            return .orange
        }
        
        return .primary
    }
    
    var body: some View {
        Group {
            if departureDate <= .now {
                Text("departureTimeView.departureNow")
            } else if Date.now.distance(to: departureDate) <= Constants.countdownStart {
                Text("departureTimeView.timerPrefix")
                + Text(verbatim: " ")
                + Text(
                    timerInterval: Date.now ... departureDate,
                    countsDown: true,
                    showsHours: false
                )
            } else {
                Text(departureDate.formatted(date: .omitted, time: .shortened))
            }
        }
        .foregroundStyle(departureColor)
    }
}

#Preview {
    List {
        ForEach(PreviewTriasService.default.allDepartures, id: \.id) { departure in
            HStack {
                Text(verbatim: "4 Durlach")
                Spacer()
                DepartureTimeView(departure: departure)
            }
        }
    }
}
