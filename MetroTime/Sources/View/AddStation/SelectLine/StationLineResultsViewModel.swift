// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

final class StationLineResultsViewModel: ViewModelProtocol {
    enum State {
        case loading
        case loaded
        case error(Error)
    }
    
    let station: any StationProtocol
    @Published var state: State
    @Published var results: [any LineProtocol]
    
    init(station: any StationProtocol, state: State, results: [any LineProtocol]) {
        self.station = station
        self.state = state
        self.results = results
    }
}

extension StationLineResultsViewModel {
    static let `default` = StationLineResultsViewModel(
        station: Station(id: "", name: "", localityID: "", locality: ""),
        state: .loading,
        results: []
    )
}
