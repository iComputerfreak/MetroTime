// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

final class AddStationViewModel: ViewModelProtocol {
    enum State {
        case loading
        case loaded
        case error(Error)
    }
    
    @Published var state: State
    @Published var searchText: String
    @Published var results: [any StationProtocol]
    
    init(state: State, searchText: String, results: [any StationProtocol]) {
        self.state = state
        self.searchText = searchText
        self.results = results
    }
}

extension AddStationViewModel {
    static let `default` = AddStationViewModel(
        state: .loading,
        searchText: "",
        results: []
    )
}
