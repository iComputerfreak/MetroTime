// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct StationResultsView: StatefulView {
    @EnvironmentObject var viewModel: AddStationViewModel
    
    var body: some View {
        if viewModel.results.isEmpty {
            ContentUnavailableView(
                title: Text("No Results"),
                systemImage: "magnifyingglas",
                description: Text("There are no results for your search.")
            )
        } else {
            List {
                // TODO: Group the results by locality
                Section {
                    ForEach(viewModel.results) { result in
                        Button {
                            // TODO: Add this station to the 
                        } label: {
                            StationRow(station: result)
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Text("Karlsruhe")
                }
            }
        }
    }
}

#Preview("Results") {
    StationResultsView()
        .environmentObject(AddStationViewModel(state: .loaded, searchText: "", results: [
            .init(id: "1", name: "Karl-Wilhelm-Platz"),
            .init(id: "2", name: "Europaplatz/Postgalerie (U)"),
            .init(id: "3", name: "Otto-Sachs-Straße")
        ]))
}

#Preview("No Results") {
    StationResultsView()
        .environmentObject(AddStationViewModel(state: .loaded, searchText: "", results: []))
}
