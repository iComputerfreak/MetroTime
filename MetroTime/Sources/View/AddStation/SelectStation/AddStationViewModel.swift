// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Combine
import Factory
import JFUtils
import SwiftUI

final class AddStationViewModel: ViewModelProtocol {
    @Published var state: LoadingState
    @Published var searchText: String
    @Published var stations: [any StationProtocol]
    @Published var isSearchFocused: Bool
    
    @Injected(\.triasService)
    private var triasService: TriasService
    
    @Injected(\.userDefaultsService)
    private var userDefaultsService: any UserDefaultsService
    
    private var updateCancellable: AnyCancellable?
    private var fetchStationsTask: Task<(), Never>?
    
    init(
        state: LoadingState = `default`.state,
        searchText: String = `default`.searchText,
        stations: [any StationProtocol] = `default`.stations,
        isSearchFocused: Bool = `default`.isSearchFocused
    ) {
        self.state = state
        self.searchText = searchText
        self.stations = stations
        self.isSearchFocused = isSearchFocused
        self.updateCancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.fetchStations()
            }
    }
    
    /// Fetches all stations matching the `searchText` from the `TriasService`
    func fetchStations() {
        guard !searchText.isEmpty else {
            stations = []
            state = .loaded
            return
        }
        
        if state == .loading {
            // Cancel the previous task and start a new one
            fetchStationsTask?.cancel()
        }
        
        state = .loading
        fetchStationsTask = Task(priority: .userInitiated) {
            do {
                // TODO: Sort sections (localities) by distance to user's location
                let stations = try await triasService.fetchStations(byName: searchText)
                await MainActor.run {
                    self.stations = stations
                    state = .loaded
                }
            } catch {
                await MainActor.run {
                    state = .error(error)
                }
            }
        }
    }
    
    /// Returns all stations in the given locality
    /// - Parameter localityID: The ID of the locality
    /// - Returns: An array of stations in the locality
    func station(in localityID: String) -> [any StationProtocol] {
        stations.filter { station in
            station.localityID == localityID
        }
    }
    
    /// Returns all localities for the stored stations
    /// - Returns: The localities (ID and name) without duplicates, sorted by their name
    func localities() -> [(id: String, name: String)] {
        stations
            .removingDuplicates(key: \.localityID)
            .map { ($0.localityID, $0.localityName) }
            .sorted(on: \.name, by: { $0.lexicographicallyPrecedes($1) })
    }
    
    deinit {
        self.fetchStationsTask?.cancel()
        self.updateCancellable?.cancel()
    }
}

extension AddStationViewModel {
    static let `default` = AddStationViewModel(
        state: .loaded,
        searchText: "",
        stations: [],
        isSearchFocused: true
    )
}
