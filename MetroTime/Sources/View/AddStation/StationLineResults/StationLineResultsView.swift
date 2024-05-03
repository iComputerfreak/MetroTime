// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct StationLineResultsView: View {
    @EnvironmentObject var viewModel: StationLineResultsViewModel
    
    var body: some View {
        List {
            if viewModel.results.isEmpty {
                ContentUnavailableView(
                    title: Text("No Results"),
                    systemImage: "magnifyingglass",
                    description: Text("There are no results for your search.")
                )
            } else {
                ForEach(viewModel.results) { line in
                    Button {
                        // TODO: Add line to favorites
                    } label: {
                        LineRow(line: line)
                    }
                }
            }
        }
    }
}

#Preview {
    StationLineResultsView()
        .environmentObject(
            StationLineResultsViewModel(
                station: Station(id: "1", name: "Otto-Sachs-Straße"),
                state: .loaded,
                results: [
                    .init(id: "1", name: "Straßenbahn 4", directionID: "dir:durlach", direction: "Durlach"),
                    .init(id: "2", name: "Straßenbahn 4", directionID: "dir:waldstadt", direction: "Waldstadt"),
                    .init(id: "3", name: "Straßenbahn 2", directionID: "dir:wolfartsweier", direction: "Wolfartsweier"),
                ]
            )
        )
        .injectPreviewServices()
}
