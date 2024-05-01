// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var stops: [String] = [
        "Karl-Wilhelm-Platz",
        "Europaplatz/Postgalerie (U)",
        "Otto-Sachs-Straße"
    ]
    
    func departures(for stop: String) -> [String] {
        return ["U1", "U2", "U3"]
    }
}

struct HomeView: View {
    @StateObject private var model: HomeViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(model.stops, id: \.self) { stop in
                    Section {
                        ForEach(model.departures(for: stop/*.id*/), id: \.self) { departure in
                            HStack {
                                Text("2 Wolfartsweier")
                                Spacer()
                                Text("--:--")
                            }
                        }
                    } header: {
                        Text(stop)
                    }
                }
            }
            .refreshable {
                
            }
            .navigationTitle(Text("Departures"))
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        
//                    } label: {
//                        Text("Test")
//                    }
//                }
//            }
        }
    }
}

#Preview {
    HomeView()
}
