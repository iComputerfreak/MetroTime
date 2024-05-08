// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import SwiftUI

struct AddStationView: StatefulView {
    @StateObject var viewModel: AddStationViewModel = .default
    
    // swiftlint:disable:next type_contents_order
    init(viewModel: AddStationViewModel = .default) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        LoadingErrorView(loadingState: $viewModel.state, loadingBackground: Color(.systemGroupedBackground)) {
            // TODO: This immediately updates as soon as we enter text, but we only want the "No Results" view after the first request
            // TODO: Maybe we need to create a custom "State" instead of a LoadingState again with `idle` case
            if viewModel.stations.isEmpty, !viewModel.searchText.isEmpty {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("stationResultsView.noResults.description")
                )
            } else {
                resultsView
            }
        }
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchFocused, prompt: Text("addStationView.searchPrompt"))
        .searchPresentationToolbarAvoidHidingContent()
        .submitLabel(.search)
        .onSubmit(of: .search, viewModel.fetchStations)
        .toolbar {
            DismissButton()
                .bold()
        }
        .navigationTitle(Text("addStationView.navTitle"))
    }
    
    private var resultsView: some View {
        List {
            ForEach(viewModel.localities(), id: \.id) { localityID, localityName in
                Section {
                    ForEach(viewModel.station(in: localityID), id: \.id) { station in
                        NavigationLink {
                            AddLineView(station: station)
                        } label: {
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
    // TODO: There are no results for this
    NavigationStack {
        AddStationView(viewModel: .init(state: .loading, searchText: "Otto-Sachs-Straße", stations: []))
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}

#Preview("No Search") {
    NavigationStack {
        AddStationView()
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}

#Preview("No Results") {
    NavigationStack {
        AddStationView(viewModel: .init(state: .loading, searchText: "Bahnhof"))
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}
