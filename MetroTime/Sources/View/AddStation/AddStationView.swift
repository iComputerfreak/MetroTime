// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct AddStationView: StatefulView {
    @StateObject var viewModel: AddStationViewModel = .default
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .task {
                    try? await Task.sleep(for: .seconds(1))
                    viewModel.results = [
                        .init(id: "1", name: "Karl-Wilhelm-Platz"),
                        .init(id: "2", name: "Europaplatz/Postgalerie (U)"),
                        .init(id: "3", name: "Otto-Sachs-Straße"),
                    ]
                    viewModel.state = .loaded
                }
        
        case .loaded:
            StationResultsView()
                .environmentObject(viewModel)
                .submitLabel(.search)
                .onSubmit(of: .search) {
                    // TODO: Trigger search manually without delay
                }
            // TODO: Add search using publisher and combine delay
        
        case let .error(error):
            ErrorView(error: error)
        }
    }
}

#Preview {
    NavigationStack {
        AddStationView()
            .navigationTitle("Add Station")
    }
}
