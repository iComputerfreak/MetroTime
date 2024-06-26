// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Factory
import Foundation

final class HomeViewModel: ViewModelProtocol {
    // All favorite stations. Not only the ones with departures.
    var stations: [any StationProtocol] {
        // TODO: Does this update the view if the UserDefaults value changes?
        userDefaultsService.getFavoriteStations()
            .sorted(on: \.name) { lhsName, rhsName in
                lhsName.lexicographicallyPrecedes(rhsName)
            }
    }
    var lines: [String: [any LineProtocol]] {
        userDefaultsService.getFavoriteLines()
    }
    @Published var departures: [String: [any DepartureProtocol]]
    @Published var loadingState: LoadingState
    @Published var isShowingAddStationSheet: Bool
    
    @Injected(\.userDefaultsService)
    private var userDefaultsService: any UserDefaultsService
    
    @Injected(\.triasService)
    private var triasService: TriasService
    
    init(
        departures: [String: [any DepartureProtocol]] = `default`.departures,
        loadingState: LoadingState = `default`.loadingState,
        showingAddStationSheet: Bool = `default`.isShowingAddStationSheet
    ) {
        self.departures = departures
        self.loadingState = loadingState
        self.isShowingAddStationSheet = showingAddStationSheet
    }
    
    /// Returns all departures for the given station
    /// - Parameter station: The station to get the departures for
    /// - Returns: An array of departures for the given station, sorted by estimated departure time
    func departures(for station: any StationProtocol) -> [any DepartureProtocol] {
        departures[station.id, default: []]
            .sorted(on: { $0.estimatedDeparture ?? $0.plannedDeparture }, by: <)
            .prefix(userDefaultsService.getNumberOfRowsPerStation())
            .asArray()
    }
    
    /// Fetches new departures from the `TriasService`
    /// - Parameter silent: Whether to enter a loading state during fetching. Set this to `true` for updates.
    func fetchDepartures(silent: Bool = false) {
        if !silent {
            loadingState = .loading
        }
        Task(priority: .userInitiated) {
            do {
                let departures = try await triasService.fetchDepartures(at: stations, lines: lines)
                await MainActor.run {
                    self.departures = departures
                    self.loadingState = .loaded
                }
            } catch {
                self.loadingState = .error(error)
            }
        }
    }
}

extension HomeViewModel {
    static let `default` = HomeViewModel(
        departures: [:],
        loadingState: .idle,
        showingAddStationSheet: false
    )
}
