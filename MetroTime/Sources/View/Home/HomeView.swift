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
                                // TODO: Move to separate view
                                HStack {
                                    Text(verbatim: "\(departure.lineName) \(departure.direction)")
                                    Spacer()
                                    Text(departure.estimatedDeparture.formatted(date: .omitted, time: .shortened))
                                }
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
        .sheet(isPresented: $viewModel.showingAddStationSheet) {
            NavigationStack {
                AddStationView()
            }
        }
    }
    
    @ToolbarContentBuilder var addButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.showingAddStationSheet = true
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
