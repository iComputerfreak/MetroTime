// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Rows per station")
                Text("Accent color")
                Text("Refresh interval")
                // Set custom colors based on the available lines at the stations the user selected
                Text("Custom Colors")
                // Allow the user to specify prefixes that should be removed from the monitor (e.g. "Straßenbahn")
                Text("Prefixes")
            }
            .toolbar {
                #if DEBUG
                    debugButton
                #endif
            }
        }
    }
    
    @ToolbarContentBuilder var debugButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                DebugView()
            } label: {
                Label("Debug", systemImage: "ladybug")
            }
        }
    }
}

#Preview {
    SettingsView()
}
