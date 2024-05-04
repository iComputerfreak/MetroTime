// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

@main
struct MetroTimeApp: App {
    // TODO: Add AppDomain and AppData packages
    // TODO: Move models into AppData and add protocols in AppDomain
    // TODO: Move existing protocols into AppDomain
    // TODO: Create service for API and for favorited stops and lines (incl. protocol)
    // TODO: Services should not use other services
    // TODO: Inject services into view hiearchy
    // TODO: If a ViewModel needs to use a service, pass it into the function that needs to use it
    
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
            .environmentObject(TriasAPI(baseURL: URL(string: "https://example.com")!))
    }
    
    func injectPreviewServices() -> some View {
        self
        // TODO: Inject mock services for preview
        // TODO: Maybe create separate "Preview" mocks?
    }
}
