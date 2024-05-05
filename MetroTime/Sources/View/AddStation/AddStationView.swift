// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import SwiftUI

struct AddStationView: StatefulView {
    @StateObject var viewModel: AddStationViewModel = .default
    
    var body: some View {
        StationResultsView()
            .environmentObject(viewModel)
            .searchable(text: $viewModel.searchText, prompt: Text("addStationView.searchPrompt"))
            .submitLabel(.search)
            .onSubmit(of: .search) {
                viewModel.fetchStations()
            }
    }
}

#Preview {
    NavigationStack {
        AddStationView()
            .navigationTitle("Add Station")
    }
    .injectPreviewEnvironment()
}
