// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import SwiftUI

struct AddStationView: StatefulView {
    @StateObject var viewModel: AddStationViewModel = .default
    @Binding var isShowingAddStationSheet: Bool
    
    var body: some View {
        LoadingErrorView(loadingState: $viewModel.state, loadingBackground: Color(.systemGroupedBackground)) {
            if viewModel.stations.isEmpty, !viewModel.searchText.isEmpty, viewModel.state == .loaded {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("stationResultsView.noResults.description")
                )
            } else if viewModel.stations.isEmpty {
                idleView
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
    
    private var idleView: some View {
        Text("addStationView.idleView.infoText")
    }
    
    private var resultsView: some View {
        List {
            ForEach(viewModel.localities(), id: \.id) { localityID, localityName in
                Section {
                    ForEach(viewModel.station(in: localityID), id: \.id) { station in
                        NavigationLink {
                            AddLineView(viewModel: .init(station: station), isShowingAddStationSheet: $isShowingAddStationSheet)
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
    NavigationStack {
        AddStationView(viewModel: .init(state: .loading, searchText: "Otto-Sachs-Straße", stations: []), isShowingAddStationSheet: .constant(false))
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}

#Preview("No Search") {
    NavigationStack {
        AddStationView(isShowingAddStationSheet: .constant(false))
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}

#Preview("No Results") {
    NavigationStack {
        AddStationView(viewModel: .init(state: .loading, searchText: "Bahnhof"), isShowingAddStationSheet: .constant(false))
            .navigationTitle(Text(verbatim: "Add Station"))
    }
    .injectPreviewEnvironment()
}
