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
    
    @Injected(\.triasService)
    private var triasService: TriasService
    
    @Injected(\.userDefaultsService)
    private var userDefaultsService: UserDefaultsService
    
    private var updateCancellable: AnyCancellable?
    private var fetchStationsTask: Task<(), Never>?
    
    init(state: LoadingState, searchText: String, results: [any StationProtocol]) {
        self.state = state
        self.searchText = searchText
        self.stations = results
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
        
        state = .loading
        fetchStationsTask = Task(priority: .userInitiated) { [weak self] in
            guard let self, !Task.isCancelled else { return }
            
            do {
                // TODO: Logging
                let stations = try await triasService.fetchStations(byName: searchText)
                await MainActor.run {
                    self.stations = stations
                    self.state = .loaded
                }
            } catch {
                await MainActor.run {
                    self.state = .error(error)
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
    
    /// Adds the given line at the given station to the favorites
    /// - Parameters:
    ///   - line: The line to add
    ///   - station: The station to add the line to
    func addFavorite(line: any LineProtocol, at station: any StationProtocol) {
        userDefaultsService.addFavoriteLine(line, at: station)
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
        results: []
    )
}
