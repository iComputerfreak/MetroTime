// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppFoundation
import Combine
import SwiftUI

struct StationResultsView: StatefulView {
    @EnvironmentObject var viewModel: AddStationViewModel
    
    @State var cancellable: AnyCancellable?
    
    // swiftlint:disable:next type_contents_order
    init() {}
    
    var body: some View {
        LoadingErrorView(loadingState: $viewModel.state, loadingBackground: Color(.systemGroupedBackground)) {
            if viewModel.stations.isEmpty {
                ContentUnavailableView(
                    "generic.noResults.title",
                    systemImage: "magnifyingglass",
                    description: Text("stationResultsView.noResults.description")
                )
            } else {
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
    }
}

#Preview("Results") {
    StationResultsView()
        .injectPreviewEnvironment()
        .environmentObject(AddStationViewModel(state: .loading, searchText: "Otto-Sachs-Straße", results: []))
}

#Preview("No Results") {
    StationResultsView()
        .injectPreviewEnvironment()
        .environmentObject(AddStationViewModel(state: .loaded, searchText: "Nobody-Street", results: []))
}
