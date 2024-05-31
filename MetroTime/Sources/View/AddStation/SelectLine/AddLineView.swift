// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct AddLineView: StatefulView {
    @StateObject var viewModel: AddLineViewModel
    @Binding var isShowingAddStationSheet: Bool
    
    var body: some View {
        LoadingErrorView(
            loadingState: $viewModel.loadingState,
            retryAction: viewModel.fetchLines,
            loadingBackground: Color(.systemGroupedBackground)
        ) {
            if viewModel.lines.isEmpty, viewModel.loadingState == .loaded {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("addLineView.noResults.description")
                )
            } else if viewModel.lines.isEmpty {
                idleView
            } else {
                resultsView
            }
        }
        .onAppear {
            viewModel.fetchLines()
        }
        .navigationTitle(viewModel.station.name)
    }
    
    private var idleView: some View {
        Text("addLineView.idleView.infoText")
    }
    
    private var resultsView: some View {
        List {
            ForEach(viewModel.lines, id: \.id) { line in
                let isFavorite = viewModel.isLineFavorite(line)
                Button {
                    viewModel.addFavoriteLine(line)
                    isShowingAddStationSheet = false
                } label: {
                    LineRow(line: line, isAdded: isFavorite)
                }
                .disabled(isFavorite)
                // Don't tint the label in the accent color
                // Even if the button is disabled, we still want it to show as normal
                .foregroundStyle(.primary)
            }
        }
        .refreshable {
            viewModel.fetchLines()
        }
    }
}

#Preview("No Results") {
    NavigationStack {
        AddLineView(
            viewModel: .init(
                loadingState: .loaded,
                station: Station(id: "", name: "", localityID: "", locality: "", latitude: 0, longitude: 0, altitude: nil),
                lines: []
            ),
            isShowingAddStationSheet: .constant(false)
        )
    }
    .injectPreviewEnvironment()
}

#Preview("Results") {
    NavigationStack {
        AddLineView(
            viewModel: .init(
                loadingState: .loading,
                station: Station(
                    id: "de:08212:1004",
                    name: "Europaplatz/Postgalerie (U)",
                    localityID: "8212000:15",
                    locality: "Karlsruhe",
                    latitude: 49.007,
                    longitude: 8.403,
                    altitude: nil
                ),
                lines: []
            ),
            isShowingAddStationSheet: .constant(false)
        )
    }
    .injectPreviewEnvironment()
}
