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
    @Published var departures: [any DepartureProtocol]
    @Published var loadingState: LoadingState = .loading
    
    @Injected(\.userDefaultsService)
    private var userDefaultsService: UserDefaultsService
    
    @Injected(\.triasService)
    private var triasService: TriasService
    
    init(departures: [any DepartureProtocol]) {
        self.departures = departures
    }
    
    func departures(for station: any StationProtocol) -> [any DepartureProtocol] {
        departures.filter { departure in
            departure.stationID == station.id
        }
    }
    
    /// Fetches new departures from the `TriasService`
    /// - Parameter silent: Whether to enter a loading state during fetching. Set this to `true` for updates.
    func fetchDepartures(silent: Bool = false) {
        if !silent {
            loadingState = .loading
        }
        Task(priority: .userInitiated) {
            do {
                let departures = try await triasService.fetchDepartures(at: stations)
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
        departures: []
    )
}
