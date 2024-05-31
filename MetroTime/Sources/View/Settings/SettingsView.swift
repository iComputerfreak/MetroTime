// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text(verbatim: "Rows per station")
                Text(verbatim: "Accent color")
                Text(verbatim: "Refresh interval")
                // Set custom colors based on the available lines at the stations the user selected
                Text(verbatim: "Custom Colors")
                // Allow the user to specify prefixes that should be removed from the monitor (e.g. "Straßenbahn")
                Text(verbatim: "Prefixes")
                // Filter station results by a locality (to reduce amount of displayed results)
                Text(verbatim: "Locality")
                // Switch between filtering by directionID or directionName (directionID is `inward`, `outward` and can contains extra results)
                // Example: Otto-Sachs-Straße, Line 5, inward: 5 Durlach Bahnhof und 5 Tullastraße
                // Problem: If we use directionName, any name changes will require the user to configure again
                Text(verbatim: "Use direction instead of direction name")
            }
            .toolbar {
                #if DEBUG
                    debugButton
                #endif
            }
            .navigationTitle(Text("settings.navTitle"))
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
