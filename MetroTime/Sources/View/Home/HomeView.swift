// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct HomeView: StatefulView {
    @StateObject var viewModel: HomeViewModel = .default
    
    var body: some View {
        NavigationStack {
            LoadingErrorView(loadingState: $viewModel.loadingState, retryAction: retry, loadingBackground: Color(.systemGroupedBackground)) {
                List {
                    ForEach(viewModel.stations, id: \.id) { station in
                        Section {
                            ForEach(viewModel.departures(for: station), id: \.id) { departure in
                                DepartureRow(departure: departure)
                            }
                        } header: {
                            Text(station.name)
                        }
                    }
                }
            }
            .refreshable {
                viewModel.fetchDepartures()
            }
            .toolbar {
                addButton
            }
            .navigationTitle(Text("homeView.navTitle"))
        }
        .onAppear {
            viewModel.fetchDepartures()
        }
        .sheet(isPresented: $viewModel.isShowingAddStationSheet) {
            NavigationStack {
                AddStationView(isShowingAddStationSheet: $viewModel.isShowingAddStationSheet)
            }
        }
        .onChange(of: viewModel.isShowingAddStationSheet) {
            // After adding a line, we should re-fetch the departures to include the new line
            if !viewModel.isShowingAddStationSheet {
                viewModel.fetchDepartures()
            }
        }
    }
    
    @ToolbarContentBuilder var addButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.isShowingAddStationSheet = true
            } label: {
                Label("homeView.addStationButton.label", systemImage: "plus")
            }
        }
    }
    
    func retry() {
        viewModel.fetchDepartures()
    }
}

#Preview {
    HomeView()
        .injectPreviewEnvironment()
}
