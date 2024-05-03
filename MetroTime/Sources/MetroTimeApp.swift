// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

@main
struct MetroTimeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .injectServices()
        }
    }
}

// TODO: Move
extension View {
    func injectServices() -> some View {
        self
            // TODO: Where to get the endpoint from? Environment? How to make secure?
            .environmentObject(TriasAPI(baseURL: URL(string: "")!))
    }
    
    func injectPreviewServices() -> some View {
        self
        // TODO: Inject mock services for preview
        // TODO: Maybe create separate "Preview" mocks?
    }
}
