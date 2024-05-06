// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct StationLineResultsView: View {
    @EnvironmentObject var viewModel: StationLineResultsViewModel
    
    var body: some View {
        List {
            if viewModel.results.isEmpty {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("stationLineResultsView.noResults.description")
                )
            } else {
                ForEach(viewModel.results, id: \.id) { line in
                    Button {
                        // TODO: Add line to favorites
                    } label: {
                        LineRow(line: line)
                    }
                    // TODO: Disable button if station is already added?
                }
            }
        }
    }
}

#Preview {
    StationLineResultsView()
        .injectPreviewEnvironment()
}
