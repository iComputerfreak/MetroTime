// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import Factory
import Foundation
import OSLog

final class AddLineViewModel: ViewModelProtocol {
    let logger = Logger("AddLineViewModel")
    let station: any StationProtocol
    @Published var loadingState: LoadingState
    @Published var lines: [any LineProtocol]
    
    @Injected(\.userDefaultsService)
    private var userDefaultsService: UserDefaultsService
    
    @Injected(\.triasService)
    private var triasService: TriasService
    
    init(
        loadingState: LoadingState = `default`.loadingState,
        station: any StationProtocol = `default`.station,
        lines: [any LineProtocol] = `default`.lines
    ) {
        self.loadingState = loadingState
        self.station = station
        self.lines = lines
    }
    
    /// Fetches all lines that depart at the stored station
    func fetchLines() {
        logger.debug("Fetching lines for \(self.station.name)")
        loadingState = .loading
        Task(priority: .userInitiated) {
            do {
                let lines = try await triasService.fetchLines(at: station)
                await MainActor.run {
                    loadingState = .loaded
                    logger.debug("Fetched \(lines.count) lines.")
                    self.lines = lines
                }
            } catch {
                loadingState = .error(error)
            }
        }
    }
    
    /// Adds the given line to the favorites
    /// - Parameter line: The line to add to the favorites
    func addFavoriteLine(_ line: any LineProtocol) {
        userDefaultsService.addFavoriteLine(line, at: station)
    }
    
    /// Returns whether the given line is a favorite
    func isLineFavorite(_ line: any LineProtocol) -> Bool {
        userDefaultsService.getFavoriteLines(at: station).contains { $0.id == line.id }
    }
}

extension AddLineViewModel {
    static let `default`: AddLineViewModel = .init(
        loadingState: .loaded,
        station: Station(id: "", name: "", localityID: "", locality: ""),
        lines: []
    )
}
