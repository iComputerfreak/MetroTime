// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct HomeView: StatefulView {
    @StateObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.stops, id: \.self) { stop in
                    Section {
                        ForEach(viewModel.departures(for: stop), id: \.self) { _ in
                            HStack {
                                Text("2 Wolfartsweier")
                                Spacer()
                                Text(
                                    ["in 5 min.", "--:--"].randomElement()!
                                )
                            }
                        }
                    } header: {
                        Text(stop)
                    }
                }
            }
            .refreshable {
                // TODO: Refresh
            }
            .toolbar {
                addButton
            }
            .navigationTitle(Text("Departures"))
        }
    }
    
    @ToolbarContentBuilder var addButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                AddStationView()
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
    }
}

#Preview {
    HomeView()
}
