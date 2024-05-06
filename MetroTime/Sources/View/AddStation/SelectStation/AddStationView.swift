// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import SwiftUI

struct AddStationView: StatefulView {
    @StateObject var viewModel: AddStationViewModel = .default
    
    var body: some View {
        LoadingErrorView(loadingState: $viewModel.state, loadingBackground: Color(.systemGroupedBackground)) {
            if viewModel.stations.isEmpty {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("stationResultsView.noResults.description")
                )
            } else {
                resultsView
            }
        }
        .searchable(text: $viewModel.searchText, prompt: Text("addStationView.searchPrompt"))
        .submitLabel(.search)
        .onSubmit(of: .search, viewModel.fetchStations)
    }
    
    private var resultsView: some View {
        List {
            ForEach(viewModel.localities(), id: \.id) { localityID, localityName in
                Section {
                    ForEach(viewModel.station(in: localityID), id: \.id) { station in
                        // TODO: This should be a nav link to the list of lines available
                        Button {} label: {
                            StationRow(station: station)
                                // Don't tint the name in the accent color
                                .tint(.primary)
                        }
                    }
                } header: {
                    Text(localityName)
                }
            }
        }
    }
}

#Preview("Results") {
    NavigationStack {
        AddStationView(viewModel: .init(state: .loading, searchText: "Otto-Sachs-Straße", results: []))
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}

#Preview("No Results") {
    NavigationStack {
        AddStationView()
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}
