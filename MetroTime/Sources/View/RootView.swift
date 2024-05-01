// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            
            LookupView()
                .tabItem { Label("Lookup", systemImage: "magnifyingglass") }
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    RootView()
}
