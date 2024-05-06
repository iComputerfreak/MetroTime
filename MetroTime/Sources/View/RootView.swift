// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("tabBar.home", systemImage: "house") }
            
            LookupView()
                .tabItem { Label("tabBar.lookup", systemImage: "magnifyingglass") }
            
            SettingsView()
                .tabItem { Label("tabBar.settings", systemImage: "gear") }
        }
    }
}

#Preview {
    RootView()
}
