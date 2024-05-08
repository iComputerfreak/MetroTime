// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct AddLineView: StatefulView {
    @StateObject var viewModel: AddLineViewModel
    
    @Environment(\.dismiss)
    private var dismiss: DismissAction
    
    // swiftlint:disable:next type_contents_order
    init(viewModel: AddLineViewModel = .default) {
        self._viewModel = StateObject(wrappedValue: .init(loadingState: viewModel.loadingState, station: viewModel.station, lines: viewModel.lines))
    }
    
    // swiftlint:disable:next type_contents_order
    init(station: any StationProtocol) {
        self.init(viewModel: .init(loadingState: .loaded, station: station, lines: []))
    }
    
    var body: some View {
        LoadingErrorView(
            loadingState: $viewModel.loadingState,
            retryAction: viewModel.fetchLines,
            loadingBackground: Color(.systemGroupedBackground)
        ) {
            if viewModel.lines.isEmpty {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("addLineView.noResults.description")
                )
            } else {
                resultsView
            }
        }
        .onAppear {
            viewModel.fetchLines()
        }
        .navigationTitle(viewModel.station.name)
    }
    
    private var resultsView: some View {
        List {
            ForEach(viewModel.lines, id: \.id) { line in
                let isFavorite = viewModel.isLineFavorite(line)
                Button {
                    viewModel.addFavoriteLine(line)
                    dismiss()
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
                station: Station(id: "", name: "", localityID: "", locality: ""),
                lines: []
            )
        )
    }
    .injectPreviewEnvironment()
}

#Preview("Results") {
    NavigationStack {
        AddLineView(
            viewModel: .init(
                loadingState: .loading,
                station: Station(id: "de:08212:1004", name: "Europaplatz/Postgalerie (U)", localityID: "8212000:15", locality: "Karlsruhe"),
                lines: []
            )
        )
    }
    .injectPreviewEnvironment()
}
