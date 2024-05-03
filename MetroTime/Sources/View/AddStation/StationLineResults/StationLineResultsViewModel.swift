// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

final class StationLineResultsViewModel: ViewModelProtocol {
    enum State {
        case loading
        case loaded
        case error(Error)
    }
    
    let station: Station
    @Published var state: State
    @Published var results: [Line]
    
    init(station: Station, state: State, results: [Line]) {
        self.station = station
        self.state = state
        self.results = results
    }
}

extension StationLineResultsViewModel {
    static let `default` = StationLineResultsViewModel(
        station: .init(id: "", name: ""),
        state: .loading,
        results: []
    )
}
