// Copyright © 2024 Jonas Frey. All rights reserved.

import Combine
import JFSwiftUI
import SwiftUI
import XMLCoder

struct DebugDeparturesView: View {
    @StateObject var viewModel: DebugDeparturesViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .task {
                        do {
                            try await viewModel.fetchDepartures()
                        } catch {
                            viewModel.state = .error(error)
                        }
                    }
                
            case let .error(error):
                VStack {
                    Text("Error!")
                        .font(.title.bold())
                    Text(error.localizedDescription)
                        .padding(.bottom)
                    
                    Text(String(describing: error))
                        .font(.caption)
                }
                
            case .loaded:
                List {
                    ForEach(viewModel.departures, id: \.resultID) { result in
                        HStack {
                            Text("\(result.line) \(result.destination)")
                            Spacer()
                            Text(result.departureString)
                                .bold(result.hasEstimatedDeparture)
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.stopID)
    }
}

private extension StopEventResult {
    var line: any StringProtocol {
        guard let lineName = stopEvent.service.serviceSection?.publishedLineName else {
            return "--"
        }
        return lineName.text.trimmingPrefix("Straßenbahn ")
    }
    
    var destination: any StringProtocol {
        return stopEvent.service.destinationText.text
    }
    
    var hasEstimatedDeparture: Bool {
        stopEvent.thisCall.callAtStop.serviceDeparture?.estimatedTime != nil
    }
    
    var departureString: String {
        if let estimated = stopEvent.thisCall.callAtStop.serviceDeparture?.estimatedTime {
            return estimated.formatted(date: .omitted, time: .shortened)
        } else if let planned = stopEvent.thisCall.callAtStop.serviceDeparture?.timetabledTime {
            return planned.formatted(date: .omitted, time: .shortened)
        } else {
            return "--:--"
        }
    }
}

extension DebugDeparturesViewModel {
    static let `default`: DebugDeparturesViewModel = .init(
        stopID: "",
        state: .loading,
        departures: []
    )
}

#Preview {
    DebugDeparturesView(viewModel: .init(stopID: "de:08317:14020"))
}
